import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/app_icon.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/features/etiquette/data/etiquette.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// "هل تعرف آداب الدعاء؟" (Figma ١٦): opens the etiquette page.
class EtiquetteEntryCard extends StatelessWidget {
  const EtiquetteEntryCard({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    return Material(
      color: context.colors.paperWarm,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.r),
        side: BorderSide(color: context.colors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(17.w, 17.h, 14.w, 17.h),
          child: Row(
            children: [
              Container(
                width: 42.r,
                height: 42.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.colors.honeyPale,
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: AppIconView(
                  AppIcon.mushaf,
                  size: 22.r,
                  color: context.colors.honey,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr(LocaleKeys.home_warm_etiquette_title),
                      style: context.textStyles.cardTitle.copyWith(
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      context.tr(
                        LocaleKeys.home_warm_etiquette_subtitle,
                        namedArgs: {
                          'count': localizedDigits(
                            etiquetteCount,
                            language,
                          ),
                        },
                      ),
                      style: context.textStyles.listCardCaption.copyWith(
                        fontSize: 11.5.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                LucideIcons.chevronRight300Dir,
                size: 22.r,
                color: context.colors.faint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "أهلًا بك في إجابة" (Figma ١٧, the end of onboarding): a green card on
/// the first Home. Tap to put it away.
class WelcomeCardView extends StatelessWidget {
  const WelcomeCardView({required this.onDismiss, super.key});

  final VoidCallback onDismiss;

  /// On green in both themes, like the hero card.
  static const _fixed = AppColors.day;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onDismiss,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: context.colors.green,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr(LocaleKeys.home_warm_welcome_title),
            style: context.textStyles.greeting.copyWith(
              fontSize: 19.sp,
              color: _fixed.paperSoft,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            context.tr(LocaleKeys.home_warm_welcome_body),
            style: context.textStyles.body.copyWith(
              fontSize: 13.sp,
              color: _fixed.greenPale,
            ),
          ),
        ],
      ),
    ),
  );
}
