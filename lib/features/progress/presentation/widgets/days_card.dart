import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/app_icon.dart';
import 'package:ijaba/core/components/sparkle.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// "أيامك مع إجابة" (Figma ١٩), in Settings above "التطبيق": how many days
/// the user has finished a set of duas, since when, and that it's between
/// them and Allah. Never on Home, never shared; it only grows.
class DaysCard extends StatelessWidget {
  const DaysCard({required this.days, required this.since, super.key});

  /// Days with duas finished; ≥ 1 (Settings shows no card before).
  final int days;

  /// The first of them.
  final DateTime since;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    final date = language == 'ar'
        ? '${localizedDigits(since.day, language)} '
              '${DateFormat.MMMM(language).format(since)} '
              '${localizedDigits(since.year, language)}'
        : DateFormat.yMMMMd(language).format(since);

    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(19.w, 19.h, 19.w, 19.h),
          decoration: BoxDecoration(
            color: context.colors.paperSoft,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: context.colors.line),
          ),
          child: Row(
            children: [
              const _Halo(),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr(LocaleKeys.days_title),
                      style: context.textStyles.listCardCaption.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          localizedDigits(days, language),
                          style: context.textStyles.counter,
                        ),
                        SizedBox(width: 6.w),
                        Flexible(
                          child: Text(
                            context.plural(LocaleKeys.days_label, days),
                            style: context.textStyles.body.copyWith(
                              fontSize: 13.sp,
                              color: context.colors.inkSoft,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      context.tr(
                        LocaleKeys.days_since,
                        namedArgs: {'date': date},
                      ),
                      style: context.textStyles.listCardCaption,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          context.tr(LocaleKeys.days_private),
          textAlign: TextAlign.center,
          style: context.textStyles.caption.copyWith(fontSize: 11.sp),
        ),
      ],
    );
  }
}

/// The Ijaba mark in a soft honey circle, a small star at its corner.
class _Halo extends StatelessWidget {
  const _Halo();

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: 64.r,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 64.r,
          height: 64.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.honeyPale,
          ),
          child: AppIconView(
            AppIcon.ijabaMark,
            size: 30.r,
            color: context.colors.honey,
          ),
        ),
        // Where the (Arabic) frame has it; it doesn't mirror.
        Positioned(
          top: 2.r,
          right: 4.r,
          child: Sparkle(size: 10.r, color: context.colors.honey),
        ),
      ],
    ),
  );
}
