import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/error_view.dart';
import 'package:ijaba/core/components/motion.dart';
import 'package:ijaba/core/controllers/clock_controller.dart';
import 'package:ijaba/features/alerts/data/datasource/alert_planner.dart';
import 'package:ijaba/features/home/presentation/controller/home_greeting_controller.dart';
import 'package:ijaba/features/home/presentation/controller/home_moments_controller.dart';
import 'package:ijaba/features/home/presentation/widgets/home_header.dart';
import 'package:ijaba/features/home/presentation/widgets/reminder_card.dart';
import 'package:ijaba/features/home/presentation/widgets/warm_cards.dart';
import 'package:ijaba/features/home/presentation/widgets/window_hero_card.dart';
import 'package:ijaba/features/home/presentation/widgets/window_row.dart';
import 'package:ijaba/features/progress/data/model/dua_week.dart';
import 'package:ijaba/features/progress/presentation/controller/dua_days_controller.dart';
import 'package:ijaba/features/progress/presentation/widgets/week_tracker.dart';
import 'package:ijaba/features/windows/presentation/controller/enabled_windows_controller.dart';
import 'package:ijaba/features/windows/presentation/controller/today_windows_controller.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(clockProvider).value ?? DateTime.now();
    final today = ref.watch(todayWindowsProvider);
    final enabled = ref.watch(enabledWindowTypesProvider);
    const planner = AlertPlanner();
    final greeting = ref.watch(homeGreetingProvider);
    final welcome = ref.watch(welcomeCardProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(22.w, 27.h, 22.w, 24.h),
          children: [
            // The warm Home (Figma ١٦): greeting, a reminder, the
            // featured window, the etiquette, then the day's windows.
            Reveal(
              child: HomeHeader(now: now, greeting: greeting),
            ),
            SizedBox(height: 16.h),
            if (welcome) ...[
              Reveal(
                delay: const Duration(milliseconds: 40),
                child: WelcomeCardView(
                  onDismiss: ref.read(welcomeCardProvider.notifier).dismiss,
                ),
              ),
              SizedBox(height: 16.h),
            ],
            Reveal(
              delay: const Duration(milliseconds: 60),
              child: ReminderCard(start: ref.watch(reminderStartProvider)),
            ),
            SizedBox(height: 16.h),
            // Figma ١٨: the week, lit by the days duas were finished.
            Reveal(
              delay: const Duration(milliseconds: 85),
              child: WeekTracker(
                week: DuaWeek(now, ref.watch(duaDaysProvider)),
              ),
            ),
            SizedBox(height: 16.h),
            // Recomputed on every clock tick: keep showing the last result.
            ...today.when(
              skipLoadingOnReload: true,
              loading: () => [
                SizedBox(height: 200.h),
                const Center(child: CircularProgressIndicator()),
              ],
              error: (error, _) => [ErrorView(error: error)],
              data: (today) => [
                if (today.hero.isNotEmpty)
                  Reveal(
                    delay: const Duration(milliseconds: 70),
                    child: WindowHeroCard(
                      windows: today.hero,
                      now: now,
                      onMakeDua: (window) =>
                          context.push(AppRoutes.duaFor(window.type.name)),
                    ),
                  ),
                SizedBox(height: 16.h),
                Reveal(
                  delay: const Duration(milliseconds: 110),
                  child: EtiquetteEntryCard(
                    onTap: () => context.push(AppRoutes.etiquette),
                  ),
                ),
                SizedBox(height: 26.h),
                // Then the list, row after row.
                Reveal(
                  delay: const Duration(milliseconds: 130),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          context.tr(LocaleKeys.home_today),
                          style: context.textStyles.sectionTitle,
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
                            style: context.textStyles.caption.copyWith(
                              fontSize: 12.sp,
                              color: context.colors.greenInk,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                if (today.windows.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Text(
                      context.tr(LocaleKeys.home_nothing_left),
                      textAlign: TextAlign.center,
                      style: context.textStyles.cardSubtitle,
                    ),
                  ),
                ...Reveal.staggered(start: const Duration(milliseconds: 170), [
                  for (final window in today.windows)
                    WindowRow(
                      window: window,
                      now: now,
                      alertOn: enabled.contains(window.type),
                      leadTime: planner.leadTimeOf(window.type),
                      onTap: () =>
                          context.push(AppRoutes.duaFor(window.type.name)),
                    ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
