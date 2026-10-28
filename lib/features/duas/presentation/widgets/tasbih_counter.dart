import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// The tap-to-count ring: "٢ من ٣". Fills softly once the target is reached.
class TasbihCounter extends StatelessWidget {
  const TasbihCounter({
    required this.count,
    required this.target,
    required this.onTap,
    super.key,
  });

  final int count;
  final int target;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    final done = count >= target;
    final ofTarget = context.tr(
      LocaleKeys.dua_of_count,
      namedArgs: {'total': localizedDigits(target, language)},
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          button: true,
          label: '${localizedDigits(count, language)} $ofTarget',
          excludeSemantics: true,
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 98.r,
              height: 98.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: done ? AppColors.honeyPale : AppColors.paperSoft,
                border: Border.all(color: AppColors.honey, width: 1.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localizedDigits(count, language),
                    style: AppTextStyles.counter,
                  ),
                  Text(
                    ofTarget,
                    style: AppTextStyles.contextSubtitle,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          context.tr(LocaleKeys.dua_tap_to_count),
          style: AppTextStyles.duaSource,
        ),
      ],
    );
  }
}
