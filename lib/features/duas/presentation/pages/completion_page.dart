import 'package:android_intent_plus/android_intent.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/ijaba_logo.dart';
import 'package:ijaba/core/components/motion.dart';
import 'package:ijaba/core/components/sparkle.dart';
import 'package:ijaba/features/duas/presentation/completion.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// What the Dua screen hands the completion screen.
typedef CompletionArgs = ({Completion completion, int nth});

/// "تقبّل الله منك" (Figma ١٤): shown on finishing a window's or shelf's
/// duas. Closing it (✕ or "الحمد لله") closes the Dua screen too.
class CompletionPage extends StatelessWidget {
  const CompletionPage({required this.args, super.key});

  final CompletionArgs args;

  /// Ar-Baqarah 2:127, from "رَبَّنَا" to the verse's end (cut from the
  /// Quran text, api.alquran.cloud "quran-simple").
  static const verse =
      'رَبَّنَا تَقَبَّلْ مِنَّا ۖ إِنَّكَ أَنْتَ السَّمِيعُ الْعَلِيمُ';

  @override
  Widget build(BuildContext context) {
    final completion = args.completion;
    final streak = completion.streakText(context, args.nth);
    final english = context.locale.languageCode != 'ar';

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: IconButton(
                        onPressed: () => context.pop(),
                        tooltip: context.tr(LocaleKeys.completion_close),
                        icon: Icon(
                          LucideIcons.x300,
                          size: 22.r,
                          color: context.colors.muted,
                        ),
                      ),
                    ),
                    const _Halo(),
                    SizedBox(height: 12.h),
                    Reveal(
                      delay: const Duration(milliseconds: 250),
                      child: Text(
                        context.tr(LocaleKeys.completion_title),
                        textAlign: TextAlign.center,
                        style: context.textStyles
                            .heroTitleFor(context.locale)
                            .copyWith(fontSize: english ? 26.sp : 34.sp),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Reveal(
                      delay: const Duration(milliseconds: 320),
                      child: Text(
                        completion.done(context),
                        textAlign: TextAlign.center,
                        style: context.textStyles.lead.copyWith(
                          fontSize: 15.sp,
                          height: 1.4,
                          color: context.colors.inkSoft,
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Reveal(
                      delay: const Duration(milliseconds: 380),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8.w,
                        runSpacing: 6.h,
                        // As in the frame: how many first, then the
                        // month's count.
                        children: [
                          _Chip(
                            text: completion.countText(context),
                            honey: true,
                          ),
                          if (streak != null) _Chip(text: streak, honey: false),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                    const Reveal(
                      delay: Duration(milliseconds: 440),
                      child: _ClosingVerse(),
                    ),
                    SizedBox(height: 14.h),
                    Reveal(
                      delay: const Duration(milliseconds: 500),
                      child: Text(
                        context.tr(LocaleKeys.completion_hadith),
                        textAlign: TextAlign.center,
                        style: context.textStyles.body.copyWith(
                          fontSize: 12.sp,
                          color: context.colors.inkSoft,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(height: 24.h),
                    FilledButton(
                      onPressed: () => context.pop(),
                      child: Text(context.tr(LocaleKeys.completion_praise)),
                    ),
                    SizedBox(height: 4.h),
                    TextButton(
                      onPressed: () => _share(context),
                      style: TextButton.styleFrom(
                        foregroundColor: context.colors.greenInk,
                        textStyle: context.textStyles.caption.copyWith(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      child: Text(
                        context.tr(LocaleKeys.completion_share),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Android's share sheet, with a line about the app. (No store link
  /// until it's published.)
  Future<void> _share(BuildContext context) async {
    final text = context.tr(LocaleKeys.completion_share_text);
    try {
      await AndroidIntent(
        action: 'android.intent.action.SEND',
        type: 'text/plain',
        arguments: {'android.intent.extra.TEXT': text},
      ).launchChooser(context.tr(LocaleKeys.app_name));
    } on Object {
      // No share sheet here (not Android): nothing to do.
    }
  }
}

/// The logo inside three rings, with sparkles around it; it all eases in.
class _Halo extends StatelessWidget {
  const _Halo();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    Widget ring(double size, Color color) => Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
    // Sparkles as in the frame: x, y, size, honey or green.
    const sparkles = [
      (25.0, 35.0, 18.0, true),
      (164.0, 28.0, 12.0, true),
      (170.0, 132.0, 16.0, false),
      (21.0, 151.0, 10.0, true),
      (100.0, 2.0, 8.0, false),
    ];
    return SizedBox.square(
      dimension: 200.r,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Reveal(
            offset: Offset.zero,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ring(200, colors.greenPale),
                ring(106, colors.paperWarm),
                IjabaLogo(size: 74.r),
              ],
            ),
          ),
          for (final (i, (x, y, size, honey)) in sparkles.indexed)
            // Where the (Arabic) frame has them; they don't mirror.
            Positioned(
              left: x.r,
              top: y.r,
              child: Reveal(
                delay: Duration(milliseconds: 180 + 70 * i),
                offset: Offset.zero,
                child: Sparkle(
                  size: size.r,
                  color: honey ? colors.honey : colors.greenMid,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text, required this.honey});

  final String text;
  final bool honey;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
    decoration: BoxDecoration(
      color: honey ? context.colors.honeyPale : context.colors.greenPale,
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Text(
      text,
      style: context.textStyles.chipValue.copyWith(
        fontSize: 12.sp,
        color: honey ? context.colors.honey : context.colors.greenInk,
      ),
    ),
  );
}

/// "اختم دعاءك": Al-Baqarah 2:127.
class _ClosingVerse extends StatelessWidget {
  const _ClosingVerse();

  @override
  Widget build(BuildContext context) {
    final english = context.locale.languageCode != 'ar';
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 18.h),
      decoration: BoxDecoration(
        color: context.colors.paperWarm,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: context.colors.line),
      ),
      child: Column(
        children: [
          Text(
            context.tr(LocaleKeys.completion_close_label),
            style: context.textStyles.caption.copyWith(
              fontSize: 11.sp,
              color: context.colors.honey,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            CompletionPage.verse,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: context.textStyles.dua.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
          ),
          if (english) ...[
            SizedBox(height: 4.h),
            Text(
              context.tr(LocaleKeys.completion_verse_meaning),
              textAlign: TextAlign.center,
              style: context.textStyles.duaMeaning,
            ),
          ],
          SizedBox(height: 12.h),
          Text(
            context.tr(LocaleKeys.completion_verse_source),
            style: context.textStyles.listCardCaption,
          ),
        ],
      ),
    );
  }
}
