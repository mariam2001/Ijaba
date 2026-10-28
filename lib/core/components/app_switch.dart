import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';

/// The design's on/off switch: a 44 × 26 track with a 20 thumb. Material's
/// [Switch] has other proportions (its thumb also changes size), so it's
/// drawn here.
///
/// It doesn't mirror in Arabic — "on" is to the right in both languages, as
/// in the design.
class AppSwitch extends StatelessWidget {
  const AppSwitch({required this.value, required this.onChanged, super.key});

  final bool value;
  final ValueChanged<bool> onChanged;

  static const _duration = Duration(milliseconds: 180);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: value,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: AnimatedContainer(
          duration: _duration,
          width: 44.r,
          height: 26.r,
          padding: EdgeInsets.all(2.r),
          decoration: BoxDecoration(
            color: value ? AppColors.green : AppColors.paperWarm,
            borderRadius: BorderRadius.circular(13.r),
            border: Border.all(
              color: value ? AppColors.green : AppColors.line,
            ),
          ),
          child: AnimatedAlign(
            duration: _duration,
            curve: Curves.easeOut,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: AnimatedContainer(
              duration: _duration,
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value ? AppColors.paperSoft : AppColors.faint,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
