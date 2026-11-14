import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/features/prayer_times/data/datasource/prayer_times_calculator.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_day.dart';
import 'package:ijaba/features/prayer_times/presentation/controller/prayer_times_controller.dart';
import 'package:ijaba/features/settings/presentation/widgets/stepper_row.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// "+٢", "−١", "٠": a signed minute count, kept left-to-right (sign then
/// digits) inside Arabic text.
String signedMinutes(int minutes, String languageCode) {
  final sign = minutes > 0 ? '+' : (minutes < 0 ? '−' : '');
  // Left-to-right isolate around the number (U+2066 ... U+2069).
  final isolate = String.fromCharCode(0x2066);
  final popIsolate = String.fromCharCode(0x2069);
  return '$isolate$sign${localizedDigits(minutes.abs(), languageCode)}'
      '$popIsolate';
}

/// Minutes to move each prayer's adhan by, showing today's calculated time
/// and, once moved, the adjusted one ("٤:٥٥ ← ٤:٥٧"). Changes apply at once
/// (and re-plan the alerts).
class AdjustmentSheet extends ConsumerWidget {
  const AdjustmentSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(prayerSettingsProvider);
    final location = ref.watch(prayerLocationProvider);
    final controller = ref.read(prayerSettingsControllerProvider.notifier);
    const limit = PrayerSettingsController.maxAdjustment;
    final language = context.locale.languageCode;

    // Today's times as calculated, and as adjusted.
    PrayerDay? today(bool adjusted) {
      if (location == null) return null;
      final now = DateTime.now();
      try {
        return const PrayerTimesCalculator().calculate(
          date: DateTime(now.year, now.month, now.day),
          location: location,
          settings: adjusted
              ? settings
              : settings.copyWith(adjustments: const {}),
        );
      } on Object {
        return null; // Polar latitudes: no times to show.
      }
    }

    final calculated = today(false);
    final adjusted = today(true);
    final clock = DateFormat('h:mm', language);
    Widget? caption(Prayer prayer) {
      if (calculated == null || adjusted == null) return null;
      final style = context.textStyles.listCardCaption;
      final from = Text(
        clock.format(calculated.adhan(prayer).toLocal()),
        style: style,
      );
      if (settings.adjustmentOf(prayer) == 0) return from;
      return Row(
        children: [
          from,
          // Points the way the text reads: leftwards in Arabic.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Icon(
              LucideIcons.arrowRight300Dir,
              size: 12.r,
              color: context.colors.muted,
            ),
          ),
          Text(
            clock.format(adjusted.adhan(prayer).toLocal()),
            style: style.copyWith(color: context.colors.greenInk),
          ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.tr(LocaleKeys.settings_adjustment_hint),
            style: context.textStyles.listCardCaption,
          ),
          SizedBox(height: 8.h),
          for (final prayer in Prayer.values)
            StepperRow(
              label: context.tr(prayerNameKey(prayer)),
              caption: caption(prayer),
              value: signedMinutes(settings.adjustmentOf(prayer), language),
              onMinus: settings.adjustmentOf(prayer) > -limit
                  ? () => controller.nudgeAdjustment(prayer, -1)
                  : null,
              onPlus: settings.adjustmentOf(prayer) < limit
                  ? () => controller.nudgeAdjustment(prayer, 1)
                  : null,
            ),
        ],
      ),
    );
  }
}
