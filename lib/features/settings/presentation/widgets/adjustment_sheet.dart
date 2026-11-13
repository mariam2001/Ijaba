import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/prayer_times/presentation/controller/prayer_times_controller.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// "+٢", "−١", "٠": a signed minute count.
String signedMinutes(int minutes, String languageCode) {
  final sign = minutes > 0 ? '+' : (minutes < 0 ? '−' : '');
  return '$sign${localizedDigits(minutes.abs(), languageCode)}';
}

/// Minutes to add to or take from each prayer's calculated time. Changes
/// apply at once (and re-plan the alerts).
class AdjustmentSheet extends ConsumerWidget {
  const AdjustmentSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(prayerSettingsProvider);
    final controller = ref.read(prayerSettingsControllerProvider.notifier);
    const limit = PrayerSettingsController.maxAdjustment;
    final language = context.locale.languageCode;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.tr(LocaleKeys.settings_adjustment_hint),
            style: AppTextStyles.listCardCaption,
          ),
          SizedBox(height: 8.h),
          for (final prayer in Prayer.values)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      context.tr(prayerNameKey(prayer)),
                      style: AppTextStyles.listCardTitle,
                    ),
                  ),
                  _Step(
                    icon: LucideIcons.minus300,
                    label: '−',
                    onTap: settings.adjustmentOf(prayer) > -limit
                        ? () => controller.nudgeAdjustment(prayer, -1)
                        : null,
                  ),
                  SizedBox(
                    width: 44.w,
                    child: Text(
                      signedMinutes(settings.adjustmentOf(prayer), language),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.rowTime,
                    ),
                  ),
                  _Step(
                    icon: LucideIcons.plus300,
                    label: '+',
                    onTap: settings.adjustmentOf(prayer) < limit
                        ? () => controller.nudgeAdjustment(prayer, 1)
                        : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onTap,
    tooltip: label,
    style: IconButton.styleFrom(
      backgroundColor: AppColors.paperSoft,
      side: const BorderSide(color: AppColors.line),
    ),
    icon: Icon(icon, size: 18.r, color: AppColors.green),
  );
}
