import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/motion.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// The tap-to-count ring: "٢ من ٣". Each tap presses it in and rolls the
/// figure up; reaching the target fills it softly and sends a halo out.
class TasbihCounter extends StatefulWidget {
  const TasbihCounter({
    required this.count,
    required this.target,
    required this.onTap,
    super.key,
  });

  final int count;
  final int target;
  final VoidCallback onTap;

  @override
  State<TasbihCounter> createState() => _TasbihCounterState();
}

class _TasbihCounterState extends State<TasbihCounter>
    with TickerProviderStateMixin {
  late final _press = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 240),
  );
  late final _halo = AnimationController(vsync: this, duration: Motion.long);

  /// 1 → 0.93 → 1 over a tap.
  late final Animation<double> _scale = TweenSequence([
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.93), weight: 35),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.93,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeOutBack)),
      weight: 65,
    ),
  ]).animate(_press);

  @override
  void didUpdateWidget(TasbihCounter old) {
    super.didUpdateWidget(old);
    if (widget.count > old.count && !Motion.reduced(context)) {
      _press.forward(from: 0);
      if (widget.count == widget.target) _halo.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _press.dispose();
    _halo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    final done = widget.count >= widget.target;
    final ofTarget = context.tr(
      LocaleKeys.dua_of_count,
      namedArgs: {'total': localizedDigits(widget.target, language)},
    );
    final size = 98.r;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          button: true,
          label: '${localizedDigits(widget.count, language)} $ofTarget',
          excludeSemantics: true,
          child: GestureDetector(
            onTap: widget.onTap,
            child: SizedBox.square(
              dimension: size,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // The halo: a ring that grows and fades once the target
                  // is reached.
                  AnimatedBuilder(
                    animation: _halo,
                    builder: (context, _) {
                      final t = Motion.curve.transform(_halo.value);
                      if (_halo.value == 0 || _halo.value == 1) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                        width: size * (1 + 0.32 * t),
                        height: size * (1 + 0.32 * t),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.colors.honey.withValues(
                              alpha: 0.5 * (1 - t),
                            ),
                            width: 1.5,
                          ),
                        ),
                      );
                    },
                  ),
                  ScaleTransition(
                    scale: _scale,
                    child: AnimatedContainer(
                      duration: Motion.of(context, Motion.medium),
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: done
                            ? context.colors.honeyPale
                            : context.colors.paperSoft,
                        border: Border.all(
                          color: context.colors.honey,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // The figure rolls up as it changes.
                          AnimatedSwitcher(
                            duration: Motion.of(context, Motion.short),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween(
                                      begin: const Offset(0, 0.35),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  ),
                                ),
                            child: Text(
                              localizedDigits(widget.count, language),
                              key: ValueKey(widget.count),
                              style: context.textStyles.counter,
                            ),
                          ),
                          Text(
                            ofTarget,
                            style: context.textStyles.contextSubtitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          context.tr(LocaleKeys.dua_tap_to_count),
          style: context.textStyles.duaSource,
        ),
      ],
    );
  }
}
