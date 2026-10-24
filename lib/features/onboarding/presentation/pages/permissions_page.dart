import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/components/error_view.dart';
import 'package:ijaba/features/alerts/presentation/controller/alerts_controller.dart';
import 'package:ijaba/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:ijaba/features/onboarding/presentation/controller/permission_steps_controller.dart';
import 'package:ijaba/features/onboarding/presentation/widgets/onboarding_layout.dart';
import 'package:ijaba/features/onboarding/presentation/widgets/step_card.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Notifications → exact alarms → the phone maker's battery / auto-launch
/// setting (the one everyone forgets). Finishes onboarding when the last
/// step is done or the user skips.
class PermissionsPage extends HookConsumerWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final steps = ref.watch(permissionStepsControllerProvider);
    final controller = ref.read(permissionStepsControllerProvider.notifier);
    final localeName = context.locale.toString();

    Future<void> finish() async {
      await ref.read(onboardingControllerProvider.notifier).complete();
      await ref
          .read(alertsControllerProvider.notifier)
          .reschedule(localeName: localeName, force: true);
      if (context.mounted) context.go(AppRoutes.home);
    }

    // Back from the settings app: re-check, and finish once all are done.
    useOnAppLifecycleStateChange((_, state) {
      if (state == AppLifecycleState.resumed) controller.refresh();
    });
    final allDone = steps.value?.current == 3;
    useEffect(() {
      if (allDone) {
        WidgetsBinding.instance.addPostFrameCallback((_) => finish());
      }
      return null;
    }, [allDone]);

    return steps.when(
      loading: () => const Scaffold(body: SizedBox.shrink()),
      error: (error, _) => Scaffold(body: ErrorView(error: error)),
      data: (steps) {
        final brand = steps.brand;
        StepStatus stateOf(int index) => index < steps.current
            ? StepStatus.done
            : index == steps.current
            ? StepStatus.current
            : StepStatus.pending;

        final actionLabel = switch (steps.current) {
          0 => context.tr(LocaleKeys.permissions_allow_notifications),
          1 => context.tr(LocaleKeys.permissions_open_exact_alarms),
          _ when brand != null => context.tr(
            LocaleKeys.permissions_open_brand_settings,
            namedArgs: {'brand': brand},
          ),
          _ => context.tr(LocaleKeys.permissions_open_battery_settings),
        };

        return OnboardingLayout(
          step: 2,
          // The text button below adds 6 px of padding above and below.
          footerSpacing: 11.h,
          bottomSpacing: 29.h,
          action: FilledButton(
            onPressed: steps.current == 3 ? null : controller.runCurrent,
            child: Text(actionLabel),
          ),
          footer: Center(
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: finish,
              child: Text(context.tr(LocaleKeys.permissions_later)),
            ),
          ),
          children: [
            SizedBox(height: 61.h),
            Text(
              context.tr(LocaleKeys.permissions_title),
              style: AppTextStyles.screenTitleFor(context.locale),
            ),
            SizedBox(height: 12.h),
            Text(
              context.tr(LocaleKeys.permissions_body),
              style: AppTextStyles.body,
            ),
            SizedBox(height: 27.h),
            StepCard(
              number: 1,
              title: context.tr(LocaleKeys.permissions_notifications),
              description: context.tr(
                LocaleKeys.permissions_notifications_hint,
              ),
              state: stateOf(0),
            ),
            SizedBox(height: 12.h),
            StepCard(
              number: 2,
              title: context.tr(LocaleKeys.permissions_exact_alarms),
              description: context.tr(
                LocaleKeys.permissions_exact_alarms_hint,
              ),
              state: stateOf(1),
            ),
            SizedBox(height: 12.h),
            StepCard(
              number: 3,
              title: context.tr(LocaleKeys.permissions_battery),
              description: brand == null
                  ? context.tr(LocaleKeys.permissions_battery_hint_generic)
                  : context.tr(
                      LocaleKeys.permissions_battery_hint_brand,
                      namedArgs: {'brand': brand},
                    ),
              state: stateOf(2),
            ),
          ],
        );
      },
    );
  }
}
