import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Wordmark with today's Hijri date ("الجمعة ١٨ ربيع الآخر"), and search.
class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.now, required this.onSearch, super.key});

  final DateTime now;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    // Umm al-Qura, by the civil date.
    final hijri = HijriCalendar.fromDate(now);
    final date = context.tr(
      LocaleKeys.home_date,
      namedArgs: {
        'weekday': DateFormat.EEEE(language).format(now),
        'day': localizedDigits(hijri.hDay, language),
        'month': context.tr('hijri_months.${hijri.hMonth}'),
      },
    );

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr(LocaleKeys.app_name),
                style: AppTextStyles.homeWordmarkFor(context.locale),
              ),
              Text(
                date,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 10.5.sp,
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
        ),
        // The glyph sits on the content edge, as in the design; the touch
        // target extends inward and vertically instead.
        GestureDetector(
          onTap: onSearch,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 14.w,
              // Slightly below centre, like the design.
              top: 14.h,
              bottom: 10.h,
            ),
            child: Icon(
              LucideIcons.search300,
              size: 20.r,
              color: AppColors.muted,
            ),
          ),
        ),
      ],
    );
  }
}
