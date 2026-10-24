import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';

/// A selectable option: title and description on the start side, a radio on
/// the end side. Selected cards are raised (paperSoft) with a green border.
class ChoiceCard extends StatelessWidget {
  const ChoiceCard({
    required this.title,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.titleStyle,
    this.padding,
    this.spacing,
    super.key,
  });

  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;

  /// Overrides [AppTextStyles.cardTitle], e.g. Amiri for "العربية".
  final TextStyle? titleStyle;

  /// Overrides the default insets, for taller (Amiri) titles.
  final EdgeInsetsGeometry? padding;

  /// Space between title and subtitle; 1 by default.
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.r),
      side: selected
          ? BorderSide(color: AppColors.green, width: 1.5.w)
          : BorderSide(color: AppColors.line, width: 1.w),
    );
    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: Material(
        color: selected ? AppColors.paperSoft : AppColors.paper,
        shape: shape,
        child: InkWell(
          onTap: onTap,
          customBorder: shape,
          child: Padding(
            padding: padding ?? EdgeInsets.fromLTRB(21.w, 19.h, 21.w, 19.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: titleStyle ?? AppTextStyles.cardTitle),
                      if (subtitle != null) ...[
                        SizedBox(height: spacing ?? 1.h),
                        Text(subtitle, style: AppTextStyles.cardSubtitle),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                _Radio(selected: selected),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Radio extends StatelessWidget {
  const _Radio({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    width: 20.r,
    height: 20.r,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: selected ? AppColors.green : null,
      border: selected
          ? null
          : Border.all(color: AppColors.faint, width: 1.5.r),
    ),
  );
}
