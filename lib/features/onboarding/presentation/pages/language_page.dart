import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_fonts.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/components/choice_card.dart';
import 'package:ijaba/core/components/ijaba_mark.dart';
import 'package:ijaba/features/onboarding/presentation/widgets/onboarding_layout.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Arabic (Arabic + meaning) or English (Arabic + transliteration +
/// meaning). The Arabic dua text never changes; only the translation does.
/// Choosing switches the app language immediately, so the preview updates.
class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  static const _arabic = Locale('ar');
  static const _english = Locale('en');

  @override
  Widget build(BuildContext context) {
    final arabic = context.locale.languageCode == _arabic.languageCode;
    final transliteration = context.tr(LocaleKeys.dua_preview_transliteration);

    return OnboardingLayout(
      action: FilledButton(
        onPressed: () => context.go(AppRoutes.welcome),
        child: Text(context.tr(LocaleKeys.language_continue)),
      ),
      footer: Text(
        context.tr(LocaleKeys.language_footer),
        textAlign: TextAlign.center,
        style: AppTextStyles.caption,
      ),
      children: [
        SizedBox(height: 65.h),
        Center(
          child: IjabaMark(width: 36.r, color: AppColors.green),
        ),
        SizedBox(height: 21.h),
        Text(
          context.tr(LocaleKeys.language_title),
          textAlign: TextAlign.center,
          style: AppTextStyles.screenTitle.copyWith(fontSize: 27.sp),
        ),
        SizedBox(height: 3.h),
        Text(
          context.tr(LocaleKeys.language_subtitle),
          textAlign: TextAlign.center,
          style: AppTextStyles.subtitle.copyWith(fontSize: 13.sp),
        ),
        SizedBox(height: 26.h),
        // Each option is laid out in its own language's direction.
        Directionality(
          textDirection: TextDirection.rtl,
          child: ChoiceCard(
            title: context.tr(LocaleKeys.language_arabic),
            subtitle: context.tr(LocaleKeys.language_arabic_hint),
            titleStyle: AppTextStyles.cardTitle.copyWith(
              fontFamily: AppFonts.amiri,
              fontSize: 19.sp,
              fontWeight: FontWeight.w700,
            ),
            padding: EdgeInsets.fromLTRB(21.w, 25.h, 21.w, 21.h),
            spacing: 5.h,
            selected: arabic,
            onTap: () => context.setLocale(_arabic),
          ),
        ),
        SizedBox(height: 12.h),
        Directionality(
          textDirection: TextDirection.ltr,
          child: ChoiceCard(
            title: context.tr(LocaleKeys.language_english),
            subtitle: context.tr(LocaleKeys.language_english_hint),
            titleStyle: AppTextStyles.cardTitle.copyWith(fontSize: 18.sp),
            padding: EdgeInsets.fromLTRB(21.w, 20.h, 21.w, 20.h),
            spacing: 2.h,
            selected: !arabic,
            onTap: () => context.setLocale(_english),
          ),
        ),
        SizedBox(height: 26.h),
        Text(
          context.tr(LocaleKeys.language_preview_label),
          style: AppTextStyles.sectionLabel,
        ),
        SizedBox(height: 8.h),
        _DuaPreview(transliteration: transliteration),
        SizedBox(height: 10.h),
        Text(
          context.tr(LocaleKeys.language_preview_note),
          textAlign: TextAlign.center,
          style: AppTextStyles.caption.copyWith(color: AppColors.muted),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}

class _DuaPreview extends StatelessWidget {
  const _DuaPreview({required this.transliteration});

  /// Empty in Arabic mode.
  final String transliteration;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 26.h),
    decoration: BoxDecoration(
      color: AppColors.greenPale,
      borderRadius: BorderRadius.circular(18.r),
    ),
    child: Column(
      children: [
        Text(
          context.tr(LocaleKeys.dua_preview_arabic),
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: AppTextStyles.dua,
        ),
        SizedBox(height: 20.h),
        Container(
          width: 40.w,
          height: 1.5,
          color: AppColors.greenMid.withValues(alpha: 0.4),
        ),
        SizedBox(height: 14.h),
        if (transliteration.isNotEmpty)
          Text(
            transliteration,
            textAlign: TextAlign.center,
            style: AppTextStyles.duaMeaning.copyWith(
              fontStyle: FontStyle.italic,
              color: AppColors.green,
            ),
          ),
        Text(
          context.tr(LocaleKeys.dua_preview_meaning),
          textAlign: TextAlign.center,
          style: AppTextStyles.duaMeaning,
        ),
      ],
    ),
  );
}
