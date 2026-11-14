import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/error_view.dart';
import 'package:ijaba/core/controllers/clock_controller.dart';
import 'package:ijaba/features/duas/data/datasource/dua_catalog.dart';
import 'package:ijaba/features/duas/presentation/controller/saved_duas_controller.dart';
import 'package:ijaba/features/duas/presentation/dua_selection.dart';
import 'package:ijaba/features/duas/presentation/widgets/dua_header.dart';
import 'package:ijaba/features/duas/presentation/widgets/dua_view.dart';
import 'package:ijaba/features/duas/presentation/widgets/tasbih_counter.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Duas one at a time: read, count, move on. Opened for a window (Home's
/// "Make dua now", a tapped alert), a Library shelf, or one search result.
///
/// Day colours for now: the design shows it at night, and the night palette
/// isn't settled yet.
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
    // Taps so far, per dua — kept when going back to an earlier one.
    final counts = useState(const <String, int>{});
    final now = ref.watch(clockProvider).value ?? DateTime.now();
    final saved = ref.watch(savedDuasProvider);
    if (duas.isEmpty) {
      return Center(
        child: Text(
          context.tr(LocaleKeys.library_no_results),
          style: context.textStyles.subtitle,
        ),
      );
    }

    final dua = duas[index.value];
    final count = counts.value[dua.id] ?? 0;

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
            title: selection.title(context),
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
                child: Text(context.tr(LocaleKeys.dua_next)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
