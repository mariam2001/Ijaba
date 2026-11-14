import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/features/windows/data/model/dua_window.dart';
import 'package:ijaba/features/windows/presentation/window_art.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// The featured window: open now (with time left and progress), or the next
/// one to open (with time until it starts).
class WindowHeroCard extends StatelessWidget {
  const WindowHeroCard({
    required this.window,
    required this.now,
    required this.onMakeDua,
    super.key,
  });

  final DuaWindow window;
  final DateTime now;
  final VoidCallback onMakeDua;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    final open = window.isOpenAt(now);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 23.h, 22.w, 22.h),
        child: _content(context, language, open: open),
      ),
    );
  }

  Widget _content(BuildContext context, String language, {required bool open}) {
    final arabic = language == 'ar';
    final countdown = Text(
      _hoursMinutes(open ? window.end : window.start, language),
      style: AppTextStyles.countdown,
    );
    final countdownLabel = Text(
      context.tr(open ? LocaleKeys.home_left : LocaleKeys.home_starts_in),
      style: AppTextStyles.heroCaption.copyWith(fontSize: 12.sp),
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
                color: open ? AppColors.honey : AppColors.greenPale,
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
              style: AppTextStyles.heroBadge.copyWith(
                letterSpacing: arabic ? null : 1.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          context.tr(windowNameKey(window.type)),
          style: AppTextStyles.heroWindowTitleFor(
            context.locale,
          ).copyWith(height: arabic ? 1.3 : 1.25),
        ),
        SizedBox(height: 5.h),
        Text(
          _timeRange(context, language),
          style: AppTextStyles.heroCaption,
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
        _Progress(fraction: open ? _elapsed : 0),
        SizedBox(height: 6.h),
        SizedBox(
          width: double.infinity,
          height: 47.h,
          child: FilledButton(
            onPressed: onMakeDua,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.paperSoft,
              foregroundColor: AppColors.green,
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

  double get _elapsed {
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
  String _timeRange(BuildContext context, String language) {
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
          color: AppColors.greenDeep,
          // Fills from the start side: right to left in Arabic.
          child: FractionallySizedBox(
            alignment: AlignmentDirectional.centerStart,
            widthFactor: fraction,
            child: const ColoredBox(color: AppColors.honey),
          ),
        ),
      ),
    );
  }
}
