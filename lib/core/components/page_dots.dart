import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';

/// Progress dots; the current one is a pill. Follows the text direction, so
/// in Arabic the first step is the rightmost dot.
class PageDots extends StatelessWidget {
  const PageDots({required this.count, required this.index, super.key});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    spacing: 7.w,
    children: [
      for (var i = 0; i < count; i++)
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: (i == index ? 20 : 7).w,
          height: 7.w,
          decoration: BoxDecoration(
            color: i == index ? AppColors.green : AppColors.line,
            borderRadius: BorderRadius.circular(4.w),
          ),
        ),
    ],
  );
}
