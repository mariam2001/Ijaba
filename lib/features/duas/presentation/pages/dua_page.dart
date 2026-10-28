import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/components/error_view.dart';
import 'package:ijaba/core/controllers/clock_controller.dart';
import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/data/model/dua.dart';
import 'package:ijaba/features/duas/presentation/controller/saved_duas_controller.dart';
import 'package:ijaba/features/duas/presentation/widgets/dua_header.dart';
import 'package:ijaba/features/duas/presentation/widgets/dua_view.dart';
import 'package:ijaba/features/duas/presentation/widgets/tasbih_counter.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// The duas for a window, one at a time: read, count, move on. Opened from
/// Home's "Make dua now"; `/dua/<window>` is also what notifications will
/// open (step 6).
///
/// Day colours for now: the design shows it at night, and the night palette
/// isn't settled yet.
class DuaPage extends ConsumerWidget {
  const DuaPage({this.window, super.key});

  /// Null when opened without one (an unknown name in the link).
  final DuaWindowType? window;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(duaCatalogProvider);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: catalog.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorView(error: error),
          data: (catalog) =>
              _DuaSequence(window: window, duas: catalog.forWindow(window)),
        ),
      ),
    );
  }
}

class _DuaSequence extends HookConsumerWidget {
  const _DuaSequence({required this.window, required this.duas});

  final DuaWindowType? window;
  final List<Dua> duas;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = useState(0);
    // Taps so far, per dua — kept when going back to an earlier one.
    final counts = useState(const <String, int>{});
    final now = ref.watch(clockProvider).value ?? DateTime.now();
    final saved = ref.watch(savedDuasProvider);
    if (duas.isEmpty) return const SizedBox.shrink();

    final dua = duas[index.value];
    final count = counts.value[dua.id] ?? 0;
    final window = this.window;

    void countOne() {
      if (count >= dua.repeat) return;
      counts.value = {...counts.value, dua.id: count + 1};
      if (count + 1 == dua.repeat) {
        HapticFeedback.mediumImpact();
      } else {
        HapticFeedback.selectionClick();
      }
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(22.w, 20.h, 22.w, 0),
          child: DuaHeader(
            title: context.tr(
              window == null ? LocaleKeys.tabs_duas : windowNameKey(window),
            ),
            now: now,
            position: index.value + 1,
            total: duas.length,
            saved: saved.contains(dua.id),
            onBack: () =>
                context.canPop() ? context.pop() : context.go(AppRoutes.home),
            onToggleSaved: () =>
                ref.read(savedDuasProvider.notifier).toggle(dua.id),
          ),
        ),
        // Centred in the space left; long duas scroll.
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
              child: DuaView(key: ValueKey(dua.id), dua: dua),
            ),
          ),
        ),
        TasbihCounter(count: count, target: dua.repeat, onTap: countOne),
        SizedBox(height: 10.h),
        _PagerBar(
          onPrevious: index.value > 0 ? () => index.value-- : null,
          onNext: index.value < duas.length - 1 ? () => index.value++ : null,
        ),
      ],
    );
  }
}

/// Previous · Next, on a bar ruled off from the dua.
class _PagerBar extends StatelessWidget {
  const _PagerBar({required this.onPrevious, required this.onNext});

  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13.r),
    );
    final size = Size.fromHeight(46.h);

    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.line)),
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
                  foregroundColor: AppColors.muted,
                  side: const BorderSide(color: AppColors.line),
                  textStyle: AppTextStyles.pagerButton,
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
                  textStyle: AppTextStyles.pagerButton,
                ),
                child: Text(context.tr(LocaleKeys.dua_next)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
