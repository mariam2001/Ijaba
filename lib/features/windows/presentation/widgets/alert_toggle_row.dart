import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/app_icon.dart';
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
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: context.colors.line)),
          ),
          child: Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: on
                      ? toggle.tileColor(context.colors)
                      : context.colors.paperWarm,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: AppIconView(
                  toggle.icon,
                  size: 20.r,
                  color: on
                      ? toggle.iconColor(context.colors)
                      : context.colors.faint,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr(toggle.titleKey),
                      style: context.textStyles.rowTitle.copyWith(
                        color: on ? context.colors.ink : context.colors.muted,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      _detail(context),
                      style: context.textStyles.caption.copyWith(
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
