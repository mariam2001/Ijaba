import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/core/components/motion.dart';

/// Which of a card's [count] pages shows (the reminder card, the hero card
/// with several windows open): the current one a short pill in
/// [activeColor], the others small dots in [color].
class CardDots extends StatelessWidget {
  const CardDots({
    required this.count,
    required this.index,
    required this.activeColor,
    required this.color,
    super.key,
  });

  final int count;
  final int index;
  final Color activeColor;
  final Color color;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (var i = 0; i < count; i++)
        AnimatedContainer(
          duration: Motion.of(context, Motion.medium),
          curve: Motion.curve,
          margin: EdgeInsets.symmetric(horizontal: 2.5.w),
          width: i == index ? 14.r : 6.r,
          height: 6.r,
          decoration: BoxDecoration(
            color: i == index ? activeColor : color,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
    ],
  );
}
