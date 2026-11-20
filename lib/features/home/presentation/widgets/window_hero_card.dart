import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/card_dots.dart';
import 'package:ijaba/core/components/motion.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/features/windows/data/model/dua_window.dart';
import 'package:ijaba/features/windows/presentation/window_art.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// The featured window: open now (with time left and progress), or the next
/// one to open (with time until it starts). When several are open at once
/// (evening adhkar and the Friday hour, say), the reader swipes between
/// them, as on the reminder card, and dots say which; it opens on the
/// first.
///
/// The card's green follows the theme; what's on it keeps its day colours
/// in both (the handover).
class WindowHeroCard extends HookWidget {
  const WindowHeroCard({
    required this.windows,
    required this.now,
    required this.onMakeDua,
    super.key,
  });

  /// `TodayWindows.hero`: never empty.
  final List<DuaWindow> windows;
  final DateTime now;

  /// "Make dua now", for the window shown.
  final ValueChanged<DuaWindow> onMakeDua;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    // The one swiped to stays while it's open; when it closes, or before
    // any swipe, the first.
    final swipedTo = useState<DuaWindow?>(null);
    final chosen = swipedTo.value;
    // indexOf gives -1 once it has closed.
    final index = chosen == null ? 0 : windows.indexOf(chosen).clamp(0, 99);
    final window = windows[index];
    final open = window.isOpenAt(now);
    final several = windows.length > 1;

    // A swipe towards the reading direction's start brings the next one.
    void swiped(DragEndDetails details) {
      final velocity = details.primaryVelocity ?? 0;
      if (velocity.abs() < 150) return;
      final towardsStart = rtl ? velocity > 0 : velocity < 0;
      swipedTo.value =
          windows[(index + (towardsStart ? 1 : -1)) % windows.length];
    }

    final card = DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.green,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 23.h, 22.w, several ? 16.h : 22.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // A new window (or this one opening) cross-fades in; the
            // clock's ticks within one don't.
            AnimatedSwitcher(
              duration: Motion.of(context, Motion.long),
              switchInCurve: Motion.curve,
              switchOutCurve: Curves.easeIn,
              layoutBuilder: (current, previous) => Stack(
                alignment: AlignmentDirectional.topStart,
                children: [...previous, ?current],
              ),
              child: KeyedSubtree(
                key: ValueKey('${window.type.name} ${window.start} $open'),
                child: _content(context, language, window, open: open),
              ),
            ),
            if (several) ...[
              SizedBox(height: 14.h),
              Center(
                child: CardDots(
                  count: windows.length,
                  index: index,
                  activeColor: _fixed.honey,
                  color: _fixed.greenDeep,
                ),
              ),
            ],
          ],
        ),
      ),
    );
    return several
        ? GestureDetector(
            onHorizontalDragEnd: swiped,
            behavior: HitTestBehavior.opaque,
            child: card,
          )
        : card;
  }

  Widget _content(
    BuildContext context,
    String language,
    DuaWindow window, {
    required bool open,
  }) {
    final arabic = language == 'ar';
    final countdown = Text(
      _hoursMinutes(open ? window.end : window.start, language),
      style: context.textStyles.countdown,
    );
    final countdownLabel = Text(
      context.tr(open ? LocaleKeys.home_left : LocaleKeys.home_starts_in),
      style: context.textStyles.heroCaption.copyWith(fontSize: 12.sp),
    );
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 7.r,
              height: 7.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: open ? _fixed.honey : _fixed.greenPale,
              ),
            ),
            SizedBox(width: 9.w),
            Text(
              arabic
                  ? context.tr(
                      open ? LocaleKeys.home_open_now : LocaleKeys.home_up_next,
                    )
                  : context
                        .tr(
                          open
                              ? LocaleKeys.home_open_now
                              : LocaleKeys.home_up_next,
                        )
                        .toUpperCase(),
              // Tracking only for Latin: spacing breaks Arabic letter joins.
              style: context.textStyles.heroBadge.copyWith(
                letterSpacing: arabic ? null : 1.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          context.tr(windowNameKey(window.type)),
          style: context.textStyles
              .heroWindowTitleFor(
                context.locale,
              )
              .copyWith(height: arabic ? 1.3 : 1.25),
        ),
        SizedBox(height: 5.h),
        Text(
          _timeRange(context, language, window),
          style: context.textStyles.heroCaption,
        ),
        SizedBox(height: 8.h),
        // Shrinks rather than overflowing with a large system font size.
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              if (open) ...[
                countdown,
                SizedBox(width: 5.w),
                countdownLabel,
              ] else ...[
                countdownLabel,
                SizedBox(width: 5.w),
                countdown,
              ],
            ],
          ),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The window's art at the end of the text (left in Arabic), centred
        // on the whole block from the badge down to the countdown. Drawn at
        // its full 160 × 120, reaching into the card's padding, and faded
        // into the card at its foot.
        Row(
          children: [
            Expanded(child: details),
            SizedBox(width: 6.w),
            SizedBox(
              width: 140.w,
              height: 120.w,
              child: OverflowBox(
                maxWidth: 160.w,
                alignment: AlignmentDirectional.centerStart,
                child: ShaderMask(
                  blendMode: BlendMode.dstIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.white, Colors.transparent],
                    stops: [0, 0.72, 1],
                  ).createShader(bounds),
                  child: SvgPicture.asset(
                    windowIllustration(window.type),
                    width: 160.w,
                    height: 120.w,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        // Empty until the window opens.
        _Progress(fraction: open ? _elapsed(window) : 0),
        SizedBox(height: 6.h),
        SizedBox(
          width: double.infinity,
          height: 47.h,
          child: FilledButton(
            onPressed: () => onMakeDua(window),
            style: FilledButton.styleFrom(
              backgroundColor: _fixed.paperSoft,
              foregroundColor: _fixed.green,
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(context.tr(LocaleKeys.home_make_dua)),
          ),
        ),
      ],
    );
  }

  double _elapsed(DuaWindow window) {
    final total = window.end.difference(window.start).inSeconds;
    final done = now.difference(window.start).inSeconds;
    return total <= 0 ? 0 : (done / total).clamp(0, 1);
  }

  /// "١:١٨" — hours and minutes until [target], rounded up to the minute.
  String _hoursMinutes(DateTime target, String language) {
    final minutes = (target.difference(now).inSeconds / 60).ceil().clamp(
      0,
      99 * 60,
    );
    final text =
        '${minutes ~/ 60}:${(minutes % 60).toString().padLeft(2, '0')}';
    return localizedNumerals(text, language);
  }

  /// "٢:٠٤ — ٤:٣٠" in Arabic; "2:04 — 4:30 AM" in English, with the
  /// prayer first for prayer windows.
  String _timeRange(
    BuildContext context,
    String language,
    DuaWindow window,
  ) {
    final clock = DateFormat('h:mm', language);
    final range =
        '${clock.format(window.start.toLocal())} — ${clock.format(window.end.toLocal())}'
        '${language == 'ar' ? '' : ' ${DateFormat('a', language).format(window.end.toLocal())}'}';
    final prayer = window.prayer;
    return prayer == null
        ? range
        : '${context.tr(prayerNameKey(prayer))} · $range';
  }
}

/// The colours on the card, the same by day and night.
const _fixed = AppColors.day;

class _Progress extends StatelessWidget {
  const _Progress({required this.fraction});

  /// Elapsed share of the window (0 before it opens: just the track).
  final double fraction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 4.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.r),
        child: ColoredBox(
          color: _fixed.greenDeep,
          // Fills from the start side (right to left in Arabic): from
          // empty when the card appears, then along with the clock.
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: fraction),
            duration: Motion.of(context, const Duration(milliseconds: 900)),
            curve: Motion.curve,
            builder: (context, value, child) => FractionallySizedBox(
              alignment: AlignmentDirectional.centerStart,
              widthFactor: value,
              child: child,
            ),
            child: ColoredBox(color: _fixed.honey),
          ),
        ),
      ),
    );
  }
}
