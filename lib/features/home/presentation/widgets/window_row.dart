import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/features/windows/data/model/dua_window.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// One line of "Today's windows": status dot, name and detail, start time.
/// Open windows get a honey dot; silent ones (after-prayer alerts are silent
/// by default) are drawn faded.
class WindowRow extends StatelessWidget {
  const WindowRow({
    required this.window,
    required this.now,
    required this.leadTime,
    super.key,
  });

  final DuaWindow window;
  final DateTime now;

  /// How long before the window its alert fires (from the alert planner).
  final Duration leadTime;

  bool get _silent => window.type == DuaWindowType.afterPrayer;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    final open = window.isOpenAt(now);
    final faded = _silent && !open;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        children: [
          Container(
            width: 7.r,
            height: 7.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: open
                  ? AppColors.honey
                  : faded
                  ? AppColors.line
                  : AppColors.greenMid,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr(windowNameKey(window.type)),
                  style: AppTextStyles.rowTitle.copyWith(
                    color: faded ? AppColors.faint : AppColors.ink,
                  ),
                ),
                Text(
                  _detail(context, language, open: open),
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 10.5.sp,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('h:mm', language).format(window.start.toLocal()),
            style: AppTextStyles.rowTime.copyWith(
              color: faded ? AppColors.faint : AppColors.ink,
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
      switch (window.type) {
        DuaWindowType.afterPrayer => context.tr(LocaleKeys.home_silent),
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
        DuaWindowType.adhanToIqama => _alertTiming(context, language),
      },
    ];
    return parts.join(' · ');
  }

  String _alertTiming(BuildContext context, String language) {
    final minutes = leadTime.inMinutes;
    if (minutes == 0) return context.tr(LocaleKeys.home_alert_at_start);
    return context.tr(
      LocaleKeys.home_alert_before,
      namedArgs: {
        'minutes': context.plural(
          LocaleKeys.home_minutes,
          minutes,
          args: [localizedDigits(minutes, language)],
        ),
      },
    );
  }
}
