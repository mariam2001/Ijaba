import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';

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

  /// Overrides [context.textStyles.cardTitle], e.g. Amiri for "العربية".
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
          ? BorderSide(color: context.colors.greenInk, width: 1.5.w)
          : BorderSide(color: context.colors.line, width: 1.w),
    );
    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: Material(
        color: selected ? context.colors.paperSoft : context.colors.paper,
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
                      Text(
                        title,
                        style: titleStyle ?? context.textStyles.cardTitle,
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: spacing ?? 1.h),
                        Text(subtitle, style: context.textStyles.cardSubtitle),
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
      color: selected ? context.colors.greenInk : null,
      border: selected
          ? null
          : Border.all(color: context.colors.faint, width: 1.5.r),
    ),
  );
}
