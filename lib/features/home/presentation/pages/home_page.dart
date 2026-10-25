import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/components/error_view.dart';
import 'package:ijaba/core/controllers/clock_controller.dart';
import 'package:ijaba/features/alerts/data/datasource/alert_planner.dart';
import 'package:ijaba/features/home/presentation/widgets/home_header.dart';
import 'package:ijaba/features/home/presentation/widgets/window_hero_card.dart';
import 'package:ijaba/features/home/presentation/widgets/window_row.dart';
import 'package:ijaba/features/windows/presentation/controller/today_windows_controller.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(clockProvider).value ?? DateTime.now();
    final today = ref.watch(todayWindowsProvider);
    const planner = AlertPlanner();
    // Until the Dua screen and Library exist (step 6), both lead to the Duas tab.
    void openDuas() => context.go(AppRoutes.duas);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(22.w, 27.h, 22.w, 24.h),
          children: [
            HomeHeader(now: now, onSearch: openDuas),
            SizedBox(height: 13.h),
            // Recomputed on every clock tick: keep showing the last result.
            ...today.when(
              skipLoadingOnReload: true,
              loading: () => [
                SizedBox(height: 200.h),
                const Center(child: CircularProgressIndicator()),
              ],
              error: (error, _) => [ErrorView(error: error)],
              data: (today) => [
                if (today.featured case final featured?)
                  WindowHeroCard(
                    window: featured,
                    now: now,
                    onMakeDua: openDuas,
                  ),
                SizedBox(height: 26.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.tr(LocaleKeys.home_today),
                        style: AppTextStyles.sectionTitle,
                      ),
                    ),
                    // Its own node, so screen readers offer it as a button.
                    Semantics(
                      container: true,
                      button: true,
                      child: GestureDetector(
                        onTap: () => context.go(AppRoutes.windows),
                        child: Text(
                          context.tr(LocaleKeys.home_edit),
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                if (today.windows.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Text(
                      context.tr(LocaleKeys.home_nothing_left),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.cardSubtitle,
                    ),
                  ),
                for (final window in today.windows)
                  WindowRow(
                    window: window,
                    now: now,
                    leadTime: planner.leadTimeOf(window.type),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
