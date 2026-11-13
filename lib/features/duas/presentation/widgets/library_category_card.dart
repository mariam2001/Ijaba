import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/features/duas/data/model/library_category.dart';
import 'package:ijaba/features/duas/presentation/library_categories.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// A Library shelf: tinted tile, name, how many it holds, and a chevron.
/// The design's tiles are plain colour — no icons yet.
class LibraryCategoryCard extends StatelessWidget {
  const LibraryCategoryCard({
    required this.category,
    required this.count,
    required this.onTap,
    super.key,
  });

  final LibraryCategory category;
  final int count;

  /// Null when there's nothing to open (no saved duas yet).
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    return Material(
      color: AppColors.paperSoft,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
        side: const BorderSide(color: AppColors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(17.w, 17.h, 16.w, 17.h),
          child: Row(
            children: [
              Container(
                width: 42.r,
                height: 42.r,
                decoration: BoxDecoration(
                  color: category.tileColor,
                  borderRadius: BorderRadius.circular(11.r),
                ),
              ),
              SizedBox(width: 13.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr(category.titleKey),
                      style: AppTextStyles.listCardTitle,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      context.plural(
                        category.countKey,
                        count,
                        args: [localizedDigits(count, language)],
                      ),
                      style: AppTextStyles.listCardCaption,
                    ),
                  ],
                ),
              ),
              Icon(
                LucideIcons.chevronRight300Dir,
                size: 22.r,
                color: AppColors.faint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
