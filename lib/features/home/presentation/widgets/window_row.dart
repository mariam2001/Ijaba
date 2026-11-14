import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/app_icon.dart';
import 'package:ijaba/features/windows/data/model/dua_window.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/presentation/alert_timing.dart';
import 'package:ijaba/features/windows/presentation/window_art.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// One line of "Today's windows": the window's icon, name and detail, start
/// time. Open windows get a honey icon; silent ones (alert switched off on
/// the Windows screen) are drawn faded.
class WindowRow extends StatelessWidget {
  const WindowRow({
    required this.window,
    required this.now,
    required this.alertOn,
    required this.leadTime,
    super.key,
  });

  final DuaWindow window;
  final DateTime now;

  /// Whether this kind of window alerts.
  final bool alertOn;

  /// How long before the window its alert fires (from the alert planner).
  final Duration leadTime;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    final open = window.isOpenAt(now);
    final faded = !alertOn && !open;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.colors.line)),
      ),
      child: Row(
        children: [
          AppIconView(
            windowIcon(window.type),
            size: 20.r,
            color: open
                ? context.colors.honey
                : faded
                ? context.colors.faint
                : context.colors.greenMid,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr(windowNameKey(window.type)),
                  style: context.textStyles.rowTitle.copyWith(
                    color: faded ? context.colors.faint : context.colors.ink,
                  ),
                ),
                Text(
                  _detail(context, language, open: open),
                  style: context.textStyles.caption.copyWith(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w300,
                    color: context.colors.muted,
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('h:mm', language).format(window.start.toLocal()),
            style: context.textStyles.rowTime.copyWith(
              color: faded ? context.colors.faint : context.colors.ink,
            ),
          ),
        ],
      ),
    );
  }

  /// "مفتوحة · تنتهي ٤:٣٠", "الفجر · تنبيه قبل ٥ دقائق", "الفجر · صامت",
  /// "الجمعة · آخر ساعة قبل المغرب".
  String _detail(BuildContext context, String language, {required bool open}) {
    if (open) {
      return context.tr(
        LocaleKeys.home_open_ends,
        namedArgs: {
          'time': DateFormat('h:mm', language).format(window.end.toLocal()),
        },
      );
    }
    final prayer = window.prayer;
    final parts = [
      if (prayer != null) context.tr(prayerNameKey(prayer)),
      if (!alertOn)
        context.tr(LocaleKeys.home_silent)
      else
        switch (window.type) {
          DuaWindowType.afterPrayer => context.tr(
            LocaleKeys.alert_control_quiet_alert,
          ),
          DuaWindowType.fridayHour =>
            '${DateFormat.EEEE(language).format(window.start.toLocal())} · '
                '${context.tr(LocaleKeys.home_friday_hour_hint)}',
          DuaWindowType.morningAdhkar => context.tr(
            LocaleKeys.home_morning_adhkar_hint,
          ),
          DuaWindowType.eveningAdhkar => context.tr(
            LocaleKeys.home_evening_adhkar_hint,
          ),
          DuaWindowType.lastThirdOfNight ||
          DuaWindowType.adhanToIqama => alertTimingText(context, leadTime),
        },
    ];
    return parts.join(' · ');
  }
}
