import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/app_icon.dart';
import 'package:ijaba/core/components/motion.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/features/etiquette/data/etiquette.dart';
import 'package:ijaba/features/home/data/reminders.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// آداب الدعاء (Figma ١٥): Ghafir 40:60, then what is recommended in dua
/// and what to avoid, each with its source, and that no dua is lost.
class EtiquettePage extends StatelessWidget {
  const EtiquettePage({super.key});

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    var number = 0;
    Widget item(Etiquette e) => _EtiquetteCard(
      etiquette: e,
      mark: e.avoid ? '!' : localizedDigits(++number, language),
    );

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(22.w, 8.h, 22.w, 28.h),
          children: Reveal.staggered([
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: IconButton(
                onPressed: () => context.pop(),
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                padding: EdgeInsets.zero,
                alignment: AlignmentDirectional.centerStart,
                icon: Icon(
                  LucideIcons.arrowLeft300Dir,
                  size: 22.r,
                  color: context.colors.ink,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            // A bold sans title here, as in the frame (not Amiri).
            Text(
              context.tr(LocaleKeys.etiquette_title),
              style: context.textStyles.greeting.copyWith(fontSize: 28.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              context.tr(LocaleKeys.etiquette_subtitle),
              style: context.textStyles.subtitle.copyWith(fontSize: 13.sp),
            ),
            SizedBox(height: 16.h),
            const _VerseCard(),
            SizedBox(height: 16.h),
            _Heading(context.tr(LocaleKeys.etiquette_do_heading)),
            for (final e in etiquette.where((e) => !e.avoid)) item(e),
            SizedBox(height: 4.h),
            _Heading(context.tr(LocaleKeys.etiquette_avoid_heading)),
            for (final e in etiquette.where((e) => e.avoid)) item(e),
            SizedBox(height: 4.h),
            const _NeverLostCard(),
            if (!etiquetteVerified) ...[
              SizedBox(height: 16.h),
              Text(
                context.tr(LocaleKeys.etiquette_verify),
                textAlign: TextAlign.center,
                style: context.textStyles.caption.copyWith(fontSize: 11.sp),
              ),
            ],
          ]),
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 14.h),
    child: Text(
      text,
      style: context.textStyles.cardTitle.copyWith(fontSize: 16.sp),
    ),
  );
}

/// "قال الله تعالى": Ghafir 40:60 on green, beside the dua hands.
class _VerseCard extends StatelessWidget {
  const _VerseCard();

  /// On green in both themes, like the hero card.
  static const _fixed = AppColors.day;

  @override
  Widget build(BuildContext context) {
    final english = context.locale.languageCode != 'ar';
    return Container(
      padding: EdgeInsets.all(22.r),
      decoration: BoxDecoration(
        color: context.colors.green,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr(LocaleKeys.etiquette_hero_label),
                  style: context.textStyles.heroCaption,
                ),
                SizedBox(height: 6.h),
                Text(
                  reminders[1].arabic,
                  textDirection: TextDirection.rtl,
                  style: context.textStyles.dua.copyWith(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: _fixed.paperSoft,
                  ),
                ),
                if (english) ...[
                  SizedBox(height: 4.h),
                  Text(
                    context.tr(LocaleKeys.etiquette_hero_meaning),
                    style: context.textStyles.heroCaption,
                  ),
                ],
                SizedBox(height: 8.h),
                Text(
                  context.tr(LocaleKeys.etiquette_hero_source),
                  style: context.textStyles.heroCaption.copyWith(
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 14.w),
          AppIconView(
            AppIcon.duaHands,
            size: 56.r,
            color: _fixed.greenPale.withValues(alpha: 0.55),
          ),
        ],
      ),
    );
  }
}

/// A numbered (or "!") tile, the title, the hadith or advice, its source.
class _EtiquetteCard extends StatelessWidget {
  const _EtiquetteCard({required this.etiquette, required this.mark});

  final Etiquette etiquette;
  final String mark;

  @override
  Widget build(BuildContext context) {
    final source = context.tr(etiquette.sourceKey);
    final avoid = etiquette.avoid;
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(17.r),
      decoration: BoxDecoration(
        color: context.colors.paperWarm,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: context.colors.line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: avoid
                  ? context.colors.honeyPale
                  : context.colors.greenPale,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              mark,
              style: context.textStyles.cardTitle.copyWith(
                fontSize: 15.sp,
                color: avoid ? context.colors.honey : context.colors.greenInk,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr(etiquette.titleKey),
                  style: context.textStyles.cardTitle.copyWith(
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  context.tr(etiquette.bodyKey),
                  style: context.textStyles.body.copyWith(
                    fontSize: 13.sp,
                    height: 1.6,
                    color: context.colors.inkSoft,
                  ),
                ),
                if (source.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    source,
                    style: context.textStyles.caption.copyWith(
                      fontSize: 11.sp,
                      color: context.colors.honey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// "دعاؤك لا يضيع": the three ways a dua is answered (Musnad Ahmad).
class _NeverLostCard extends StatelessWidget {
  const _NeverLostCard();

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(20.r),
    decoration: BoxDecoration(
      color: context.colors.honeyPale,
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr(LocaleKeys.etiquette_kept_title),
          style: context.textStyles.cardTitle.copyWith(fontSize: 17.sp),
        ),
        SizedBox(height: 6.h),
        Text(
          context.tr(LocaleKeys.etiquette_kept_body),
          style: context.textStyles.body.copyWith(
            fontSize: 13.sp,
            height: 1.7,
            color: context.colors.inkSoft,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          context.tr(LocaleKeys.etiquette_kept_source),
          style: context.textStyles.caption.copyWith(
            fontSize: 11.sp,
            color: context.colors.honey,
          ),
        ),
      ],
    ),
  );
}
