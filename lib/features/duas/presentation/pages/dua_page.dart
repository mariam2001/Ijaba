import 'dart:math';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/error_view.dart';
import 'package:ijaba/core/components/motion.dart';
import 'package:ijaba/core/controllers/clock_controller.dart';
import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/presentation/completion.dart';
import 'package:ijaba/features/duas/presentation/controller/completion_log_controller.dart';
import 'package:ijaba/features/duas/presentation/controller/dua_catalog_controller.dart';
import 'package:ijaba/features/duas/presentation/controller/saved_duas_controller.dart';
import 'package:ijaba/features/duas/presentation/dua_selection.dart';
import 'package:ijaba/features/duas/presentation/widgets/dua_header.dart';
import 'package:ijaba/features/duas/presentation/widgets/dua_view.dart';
import 'package:ijaba/features/duas/presentation/widgets/tasbih_counter.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Duas one at a time: read, count, move on. Opened for a window (Home's
/// "Make dua now", a tapped alert), a Library shelf, or one search result.
/// Follows the theme (the design shows it at night).
class DuaPage extends ConsumerWidget {
  const DuaPage({required this.selection, super.key});

  final DuaSelection selection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(duaCatalogProvider);
    // Opened from a notification it's the only page: Back then goes Home
    // rather than closing the app.
    return PopScope(
      canPop: context.canPop(),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go(AppRoutes.home);
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: catalog.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => ErrorView(error: error),
            data: (catalog) =>
                _DuaSequence(selection: selection, catalog: catalog),
          ),
        ),
      ),
    );
  }
}

class _DuaSequence extends HookConsumerWidget {
  const _DuaSequence({required this.selection, required this.catalog});

  final DuaSelection selection;
  final DuaCatalog catalog;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fixed for the visit: un-saving a dua while reading the saved ones
    // shouldn't pull it out from under the reader.
    final duas = useMemoized(
      () => selection.duasIn(catalog, ref.read(savedDuasProvider)),
      [catalog],
    );
    final index = useState(0);
    // Which way the last step went: the next dua comes in from the end
    // side (the left in Arabic), the previous one from the start.
    final previousIndex = usePrevious(index.value);
    final forward = previousIndex == null || index.value >= previousIndex;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    // Taps so far, per dua — kept when going back to an earlier one.
    final counts = useState(const <String, int>{});
    final now = ref.watch(clockProvider).value ?? DateTime.now();
    final saved = ref.watch(savedDuasProvider);
    // Shows "اكتمل التسبيح" for a moment: fades in, stays, fades out.
    final toast = useAnimationController(
      duration: const Duration(milliseconds: 2600),
    );
    if (duas.isEmpty) {
      return Center(
        child: Text(
          context.tr(LocaleKeys.library_no_results),
          style: context.textStyles.subtitle,
        ),
      );
    }

    // In range even if the user just deleted one of their own duas.
    final dua = duas[min(index.value, duas.length - 1)];
    final count = counts.value[dua.id] ?? 0;

    void countOne() {
      if (count >= dua.repeat) return;
      counts.value = {...counts.value, dua.id: count + 1};
      if (count + 1 == dua.repeat) {
        HapticFeedback.mediumImpact();
        // "اكتمل التسبيح" for a dhikr said more than once.
        if (dua.repeat > 1) toast.forward(from: 0);
      } else {
        HapticFeedback.selectionClick();
      }
    }

    // The last dua's "Next" finishes: the completion screen, then back to
    // where the Dua screen was opened from.
    final completion = Completion.of(selection, duas.length);
    final last = index.value >= duas.length - 1;
    Future<void> finish() async {
      final nth = await ref
          .read(completionLogProvider.notifier)
          .record(completion!.key, DateTime.now());
      if (!context.mounted) return;
      await context.push(
        AppRoutes.completion,
        extra: (completion: completion, nth: nth),
      );
      if (!context.mounted) return;
      context.canPop() ? context.pop() : context.go(AppRoutes.home);
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(22.w, 20.h, 22.w, 0),
          child: DuaHeader(
            title: selection.title(context),
            now: now,
            position: index.value + 1,
            total: duas.length,
            saved: saved.contains(dua.id),
            onBack: () =>
                context.canPop() ? context.pop() : context.go(AppRoutes.home),
            onToggleSaved: () =>
                ref.read(savedDuasProvider.notifier).toggle(dua.id),
            onEdit: dua.mine
                ? () => context.push(AppRoutes.myDuaEdit(dua.id))
                : null,
          ),
        ),
        // Centred in the space left; long duas (Al 'Imran 190–200 on
        // waking) scroll, fading out at the edges rather than cut mid-line.
        // Each dua starts at its top.
        Expanded(
          // The toast floats over the foot of the dua, taking no room.
          child: Stack(
            children: [
              Positioned.fill(
                child: ShaderMask(
                  blendMode: BlendMode.dstIn,
                  shaderCallback: (bounds) {
                    final fade = bounds.height == 0
                        ? 0.0
                        : 18.h / bounds.height;
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: const [
                        Colors.transparent,
                        Colors.white,
                        Colors.white,
                        Colors.transparent,
                      ],
                      stops: [0, fade, 1 - fade, 1],
                    ).createShader(bounds);
                  },
                  child: AnimatedSwitcher(
                    duration: Motion.of(context, Motion.medium),
                    switchInCurve: Motion.curve,
                    switchOutCurve: Curves.easeIn,
                    // Rebuilt each time with the current direction, so the dua
                    // leaving slides out the way the new one pushes it.
                    transitionBuilder: (child, animation) {
                      final incoming = child.key == ValueKey(dua.id);
                      final towardsEnd = forward == incoming;
                      final dx = 0.12 * (towardsEnd ? 1 : -1) * (rtl ? -1 : 1);
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween(
                            begin: Offset(dx, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Center(
                      key: ValueKey(dua.id),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 16.h,
                        ),
                        child: DuaView(dua: dua),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _TasbihToast(animation: toast),
              ),
            ],
          ),
        ),
        // Its own per dua, so stepping to another doesn't count as a tap.
        TasbihCounter(
          key: ValueKey(dua.id),
          count: count,
          target: dua.repeat,
          onTap: countOne,
        ),
        SizedBox(height: 10.h),
        _PagerBar(
          onPrevious: index.value > 0 ? () => index.value-- : null,
          onNext: !last
              ? () => index.value++
              : completion == null
              ? null
              : finish,
          finishes: last && completion != null,
        ),
      ],
    );
  }
}

/// Previous · Next, on a bar ruled off from the dua.
class _PagerBar extends StatelessWidget {
  const _PagerBar({
    required this.onPrevious,
    required this.onNext,
    required this.finishes,
  });

  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  /// On the last dua: "تمّ" rather than "التالي".
  final bool finishes;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13.r),
    );
    final size = Size.fromHeight(46.h);
    final night = context.colors.isNight;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.colors.line)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 17.h, 20.w, max(bottomInset, 30.h)),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onPrevious,
                style: OutlinedButton.styleFrom(
                  minimumSize: size,
                  shape: shape,
                  foregroundColor: context.colors.muted,
                  side: BorderSide(color: context.colors.line),
                  textStyle: context.textStyles.pagerButton,
                ),
                child: Text(context.tr(LocaleKeys.dua_previous)),
              ),
            ),
            SizedBox(width: 11.w),
            Expanded(
              child: FilledButton(
                onPressed: onNext,
                style: FilledButton.styleFrom(
                  minimumSize: size,
                  shape: shape,
                  // Honey by night, as in the night Dua design.
                  backgroundColor: night ? context.colors.honey : null,
                  foregroundColor: night ? context.colors.paper : null,
                  textStyle: context.textStyles.pagerButton,
                ),
                child: Text(
                  context.tr(
                    finishes ? LocaleKeys.dua_done : LocaleKeys.dua_next,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "✓ اكتمل التسبيح — زادك الله من فضله" (Figma ١٧), in the space above
/// the counter; driven by [animation] (0 → 1 over its life).
class _TasbihToast extends StatelessWidget {
  const _TasbihToast({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: animation,
    builder: (context, child) {
      final t = animation.value;
      // In over the first tenth, out over the last fifth.
      final opacity = t <= 0 || t >= 1
          ? 0.0
          : t < 0.1
          ? t / 0.1
          : t > 0.8
          ? (1 - t) / 0.2
          : 1.0;
      return SizedBox(
        height: 56.h,
        child: opacity == 0
            ? null
            : Opacity(
                opacity: opacity,
                child: Center(child: child),
              ),
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 22.w),
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: context.colors.ink,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.check300, size: 15.r, color: context.colors.paper),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              context.tr(LocaleKeys.dua_tasbih_complete),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textStyles.chipLabel.copyWith(
                color: context.colors.paper,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
