import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

enum StepStatus { done, current, pending }

/// One step of the Permissions screen. Done steps are quiet with a check;
/// the current one is raised with a honey border and its number.
class StepCard extends StatelessWidget {
  const StepCard({
    required this.number,
    required this.title,
    required this.description,
    required this.state,
    super.key,
  });

  final int number;
  final String title;
  final String description;
  final StepStatus state;

  @override
  Widget build(BuildContext context) {
    final current = state == StepStatus.current;
    final done = state == StepStatus.done;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: current ? context.colors.paperSoft : context.colors.paper,
        borderRadius: BorderRadius.circular(18.r),
        border: current
            ? Border.all(color: context.colors.honey, width: 1.5.r)
            : Border.all(color: context.colors.line, width: 1.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Badge(number: number, state: state),
          SizedBox(width: 13.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  // Tight line box so the title lines up with the badge.
                  style: context.textStyles.cardTitle.copyWith(
                    height: 1,
                    color: done ? context.colors.muted : context.colors.ink,
                  ),
                ),
                SizedBox(height: 9.5.h),
                Text(
                  description,
                  style: context.textStyles.cardSubtitle.copyWith(
                    color: done
                        ? context.colors.faint
                        : current
                        ? context.colors.inkSoft
                        : context.colors.muted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.number, required this.state});

  final int number;
  final StepStatus state;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (state) {
      StepStatus.done => (context.colors.green, context.colors.onGreen),
      StepStatus.current => (context.colors.honeyPale, context.colors.honey),
      StepStatus.pending => (context.colors.paperWarm, context.colors.muted),
    };
    return Container(
      width: 28.r,
      height: 28.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: state == StepStatus.done
          ? Icon(LucideIcons.check300, size: 17.r, color: foreground)
          : Text(
              localizedDigits(number, context.locale.languageCode),
              style: context.textStyles.cardSubtitle.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: foreground,
                height: 1,
              ),
            ),
    );
  }
}
