import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/motion.dart';
import 'package:ijaba/features/home/data/reminders.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// "تذكير · يتجدّد كلما فتحت التطبيق" (Figma ١٦): a verse about dua, a
/// different one each time the app opens; swipe sideways for the others.
/// The dots say which. The card takes the verse's height.
class ReminderCard extends HookWidget {
  const ReminderCard({required this.start, super.key});

  /// The reminder to open on.
  final int start;

  @override
  Widget build(BuildContext context) {
    final page = useState(start);
    final english = context.locale.languageCode != 'ar';
    final rtl = Directionality.of(context) == TextDirection.rtl;
    final reminder = reminders[page.value];

    // A swipe towards the reading direction's start brings the next one.
    void swiped(DragEndDetails details) {
      final velocity = details.primaryVelocity ?? 0;
      if (velocity.abs() < 150) return;
      final towardsStart = rtl ? velocity > 0 : velocity < 0;
      final step = towardsStart ? 1 : -1;
      page.value = (page.value + step) % reminders.length;
    }

    return GestureDetector(
      onHorizontalDragEnd: swiped,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 18.h),
        decoration: BoxDecoration(
          color: context.colors.paperSoft,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: context.colors.line),
        ),
        child: Column(
          children: [
            Text(
              context.tr(LocaleKeys.home_warm_reminder_label),
              textAlign: TextAlign.center,
              style: context.textStyles.caption.copyWith(
                fontSize: 11.sp,
                color: context.colors.honey,
              ),
            ),
            SizedBox(height: 8.h),
            AnimatedSize(
              duration: Motion.of(context, Motion.medium),
              curve: Motion.curve,
              child: AnimatedSwitcher(
                duration: Motion.of(context, Motion.medium),
                child: Column(
                  key: ValueKey(page.value),
                  children: [
                    Text(
                      reminder.arabic,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: context.textStyles.dua.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    if (english) ...[
                      SizedBox(height: 4.h),
                      Text(
                        context.tr(reminder.meaningKey),
                        textAlign: TextAlign.center,
                        style: context.textStyles.duaMeaning,
                      ),
                    ],
                    SizedBox(height: 6.h),
                    Text(
                      context.tr(reminder.sourceKey),
                      style: context.textStyles.listCardCaption,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            _Dots(count: reminders.length, index: page.value),
          ],
        ),
      ),
    );
  }
}

/// The current one long and honey, the others small dots.
class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});

  final int count;
  final int index;

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
            color: i == index ? context.colors.honey : context.colors.line,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
    ],
  );
}
