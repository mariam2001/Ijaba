import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/features/duas/data/model/dua.dart';

/// One search hit: the start of the dua, and its meaning (English) or source
/// (Arabic) under it. No design yet — styled like the Library's cards.
class DuaSearchResult extends StatelessWidget {
  const DuaSearchResult({required this.dua, required this.onTap, super.key});

  final Dua dua;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    final meaning = dua.meaningIn(language);
    final detail = meaning.isNotEmpty ? meaning : dua.sourceIn(language) ?? '';

    return Material(
      color: context.colors.paperSoft,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
        side: BorderSide(color: context.colors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                dua.arabic,
                // The dua is Arabic whatever the app language.
                textDirection: TextDirection.rtl,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textStyles.duaLarge.copyWith(
                  fontSize: 18.sp,
                  height: 1.8,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                detail,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textStyles.listCardCaption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
