import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/components/branch_ornament.dart';
import 'package:ijaba/features/duas/data/model/dua.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// A dua as the Dua screen shows it: the Arabic (always), the
/// transliteration in English mode, the meaning, and the source — flagged
/// until verified.
class DuaView extends StatelessWidget {
  const DuaView({required this.dua, super.key});

  final Dua dua;

  /// Characters (with harakat) beyond which the dua is set smaller.
  static const _longText = 120;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    final arabic = language == 'ar';
    final meaning = dua.meaningIn(language);
    final source = dua.sourceIn(language);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          dua.arabic,
          textAlign: TextAlign.center,
          // The dua is Arabic whatever the app language.
          textDirection: TextDirection.rtl,
          // Long texts (Ayat al-Kursi, the three Quls) smaller, so they
          // don't need much scrolling.
          style: dua.arabic.length > _longText
              ? AppTextStyles.duaLarge.copyWith(fontSize: 26.sp)
              : AppTextStyles.duaLarge,
        ),
        if (!arabic) ...[
          SizedBox(height: 28.h),
          Text(
            dua.transliteration,
            textAlign: TextAlign.center,
            style: AppTextStyles.transliteration,
          ),
        ],
        SizedBox(height: 26.h),
        // As in the design: the branch in Arabic, a short rule in English.
        if (arabic)
          BranchOrnament(
            width: 108.r,
            color: AppColors.greenMid.withValues(alpha: 0.45),
          )
        else
          Container(width: 54.w, height: 1.5, color: AppColors.line),
        if (meaning.isNotEmpty) ...[
          SizedBox(height: arabic ? 43.h : 24.h),
          Text(
            meaning,
            textAlign: TextAlign.center,
            style: AppTextStyles.duaMeaningLarge,
          ),
        ],
        SizedBox(height: 24.h),
        Text(
          [
            ?source,
            if (!dua.verified) context.tr(LocaleKeys.dua_verify_source),
          ].join('\n'),
          textAlign: TextAlign.center,
          style: AppTextStyles.duaSource,
        ),
      ],
    );
  }
}
