import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/logo_star.dart';
import 'package:ijaba/core/components/motion.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/features/progress/data/model/dua_week.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// "أسبوعك مع الدعاء" (Figma ١٨), under the reminder on Home: the week from
/// Saturday (on the right in Arabic), each day lit by finishing a set of
/// duas, and a line that changes with the week.
class WeekTracker extends StatelessWidget {
  const WeekTracker({required this.week, super.key});

  final DuaWeek week;

  static const _dayKeys = [
    LocaleKeys.week_sat,
    LocaleKeys.week_sun,
    LocaleKeys.week_mon,
    LocaleKeys.week_tue,
    LocaleKeys.week_wed,
    LocaleKeys.week_thu,
    LocaleKeys.week_fri,
  ];

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    return Container(
      padding: EdgeInsets.fromLTRB(19.w, 19.h, 19.w, 17.h),
      decoration: BoxDecoration(
        color: context.colors.paperSoft,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.colors.line),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.tr(LocaleKeys.week_title),
                  style: context.textStyles.cardTitle.copyWith(
                    fontSize: 14.5.sp,
                  ),
                ),
              ),
              Text(
                context.tr(
                  LocaleKeys.week_count,
                  namedArgs: {
                    'done': localizedDigits(week.done, language),
                    'total': localizedDigits(7, language),
                  },
                ),
                style: context.textStyles.chipValue.copyWith(
                  fontSize: 12.sp,
                  color: context.colors.honey,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          // A seventh of the row each, as the frame spaces them.
          Row(
            children: [
              for (final (i, mark) in week.marks.indexed)
                Expanded(
                  child: _Day(
                    mark: mark,
                    friday: i == 6,
                    label: context.tr(_dayKeys[i]),
                  ),
                ),
            ],
          ),
          SizedBox(height: 14.h),
          AnimatedSwitcher(
            duration: Motion.of(context, Motion.medium),
            child: Text(
              context.tr(switch (week.line) {
                WeekLine.midWeek => LocaleKeys.week_line_mid,
                WeekLine.full => LocaleKeys.week_line_full,
                WeekLine.saturday => LocaleKeys.week_line_saturday,
              }),
              key: ValueKey(week.line),
              textAlign: TextAlign.center,
              style: context.textStyles.body.copyWith(
                fontSize: 12.sp,
                height: 1.5,
                color: context.colors.inkSoft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// One day: its mark over its name. A day lighting up (back from the
/// completion screen) pops its star in.
class _Day extends StatelessWidget {
  const _Day({required this.mark, required this.friday, required this.label});

  final DayMark mark;
  final bool friday;
  final String label;

  static const _size = 34.0;

  /// The star stays white in both themes: it sits on honey.
  static final _star = AppColors.day.paperSoft;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final today = mark == DayMark.today || mark == DayMark.todayDone;
    final lit = mark == DayMark.done || mark == DayMark.todayDone;

    final Widget circle = switch (mark) {
      DayMark.done || DayMark.todayDone => Container(
        width: _size.r,
        height: _size.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.honey,
          // Today's green ring, a breath away from the honey.
          border: mark == DayMark.todayDone
              ? Border.all(color: colors.greenInk, width: 2)
              : null,
        ),
        // Friday's star is bigger: a special day.
        child: LogoStar(height: (friday ? 20 : 13).r, color: _star),
      ),
      DayMark.today => Container(
        width: _size.r,
        height: _size.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colors.greenInk, width: 2),
        ),
      ),
      // Quiet sand: the recessed paper by day; by night that's near black,
      // so the hairline colour instead.
      DayMark.missed => Container(
        width: _size.r,
        height: _size.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.isNight ? colors.line : colors.paperWarm,
          border: Border.all(color: colors.line),
        ),
      ),
      DayMark.future => CustomPaint(
        size: Size.square(_size.r),
        painter: _DashedCircle(colors.line),
      ),
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: Motion.of(context, Motion.long),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: lit ? Curves.easeOutBack : Curves.easeOut,
            ),
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: KeyedSubtree(key: ValueKey(mark), child: circle),
        ),
        SizedBox(height: 6.h),
        // Shrinks rather than overflowing with a large system font.
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            style: context.textStyles.caption.copyWith(
              fontSize: 10.sp,
              fontWeight: today ? FontWeight.w600 : null,
              color: today ? colors.greenInk : colors.muted,
            ),
          ),
        ),
      ],
    );
  }
}

/// A faint dashed circle: a day still to come.
class _DashedCircle extends CustomPainter {
  const _DashedCircle(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final rect = Offset.zero & size;
    const dashes = 16;
    const sweep = 2 * 3.141592653589793 / dashes;
    for (var i = 0; i < dashes; i++) {
      canvas.drawArc(rect.deflate(0.6), i * sweep, sweep * 0.55, false, paint);
    }
  }

  @override
  bool shouldRepaint(_DashedCircle old) => old.color != color;
}
