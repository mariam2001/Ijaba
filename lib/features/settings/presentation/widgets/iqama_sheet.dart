import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/settings/presentation/widgets/stepper_row.dart';
import 'package:ijaba/features/windows/data/model/window_config.dart';
import 'package:ijaba/features/windows/presentation/controller/window_config_controller.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// When the iqama comes after each adhan, how long the prayer takes, and how
/// long the after-prayer window stays open — none is fixed by a rule, so the
/// user sets them. Changes apply at once (and re-plan the alerts).
class IqamaSheet extends ConsumerWidget {
  const IqamaSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(windowConfigProvider);
    final controller = ref.read(windowConfigControllerProvider.notifier);
    final language = context.locale.languageCode;
    String minutes(Duration duration) =>
        localizedDigits(duration.inMinutes, language);

    VoidCallback? step(
      Duration current,
      ({int min, int max}) range,
      int delta,
      Future<void> Function(int delta) nudge,
    ) {
      final next = current.inMinutes + delta;
      return next < range.min || next > range.max ? null : () => nudge(delta);
    }

    const iqama = WindowConfigController.iqamaRange;
    const prayer = WindowConfigController.prayerRange;
    const afterPrayer = WindowConfigController.afterPrayerRange;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.tr(LocaleKeys.settings_iqama_hint),
            style: AppTextStyles.listCardCaption,
          ),
          SizedBox(height: 12.h),
          Text(
            context.tr(LocaleKeys.settings_iqama_after),
            style: AppTextStyles.sectionLabel,
          ),
          for (final p in Prayer.values)
            StepperRow(
              label: context.tr(prayerNameKey(p)),
              value: minutes(config.iqamaDelay(p)),
              onMinus: step(
                config.iqamaDelay(p),
                iqama,
                -1,
                (d) => controller.nudgeIqama(p, d),
              ),
              onPlus: step(
                config.iqamaDelay(p),
                iqama,
                1,
                (d) => controller.nudgeIqama(p, d),
              ),
            ),
          SizedBox(height: 8.h),
          StepperRow(
            label: context.tr(LocaleKeys.settings_prayer_length),
            value: minutes(config.prayerDuration),
            onMinus: step(
              config.prayerDuration,
              prayer,
              -1,
              controller.nudgePrayerDuration,
            ),
            onPlus: step(
              config.prayerDuration,
              prayer,
              1,
              controller.nudgePrayerDuration,
            ),
          ),
          StepperRow(
            label: context.tr(LocaleKeys.settings_after_prayer_length),
            value: minutes(config.afterPrayerDuration),
            onMinus: step(
              config.afterPrayerDuration,
              afterPrayer,
              -1,
              controller.nudgeAfterPrayerDuration,
            ),
            onPlus: step(
              config.afterPrayerDuration,
              afterPrayer,
              1,
              controller.nudgeAfterPrayerDuration,
            ),
          ),
          if (config != const WindowConfig())
            TextButton(
              onPressed: controller.reset,
              child: Text(context.tr(LocaleKeys.settings_reset)),
            ),
        ],
      ),
    );
  }
}
