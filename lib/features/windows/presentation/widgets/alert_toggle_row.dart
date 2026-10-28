import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/components/app_switch.dart';
import 'package:ijaba/features/alerts/data/datasource/alert_planner.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/presentation/alert_timing.dart';
import 'package:ijaba/features/windows/presentation/alert_toggles.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// One switch on the Windows screen: name, what the alert does, and the
/// switch. The whole row toggles; switched-off rows are muted.
class AlertToggleRow extends StatelessWidget {
  const AlertToggleRow({
    required this.toggle,
    required this.on,
    required this.onChanged,
    super.key,
  });

  final AlertToggle toggle;
  final bool on;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    // One node for screen readers: "name, detail, switch, on".
    return MergeSemantics(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onChanged(!on),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.line)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr(toggle.titleKey),
                      style: AppTextStyles.rowTitle.copyWith(
                        color: on ? AppColors.ink : AppColors.muted,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      _detail(context),
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              AppSwitch(value: on, onChanged: onChanged),
            ],
          ),
        ),
      ),
    );
  }

  String _detail(BuildContext context) => switch (toggle) {
    AlertToggle.lastThird =>
      '${alertTimingText(context, const AlertPlanner().leadTimeOf(DuaWindowType.lastThirdOfNight))}'
          ' · ${context.tr(LocaleKeys.alert_control_soft_chime)}',
    AlertToggle.adhanToIqama => context.tr(
      LocaleKeys.alert_control_fajr_maghrib_only,
    ),
    AlertToggle.afterPrayer => context.tr(
      on
          ? LocaleKeys.alert_control_quiet_alert
          : LocaleKeys.alert_control_silent_no_alert,
    ),
    AlertToggle.fridayHour => context.tr(
      LocaleKeys.alert_control_friday_hour_hint,
    ),
    AlertToggle.adhkar => context.tr(LocaleKeys.alert_control_one_each),
  };
}
