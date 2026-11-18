import 'package:flutter/material.dart';

/// The app's motion: things move when they change and keep still at rest
/// (no looping animations), and nothing moves when the phone's "remove
/// animations" setting is on.
abstract final class Motion {
  static const short = Duration(milliseconds: 180);
  static const medium = Duration(milliseconds: 320);
  static const long = Duration(milliseconds: 520);

  static const curve = Curves.easeOutCubic;

  /// The phone asks for no animations (accessibility).
  static bool reduced(BuildContext context) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  /// [duration], or none when animations are off.
  static Duration of(BuildContext context, Duration duration) =>
      reduced(context) ? Duration.zero : duration;
}

/// Fades [child] in and lifts it into place, once, when it first appears —
/// after [delay], so a screen's parts can arrive one after another.
///
/// The delay is part of the animation itself rather than a timer, so a
/// screen that closes early leaves nothing pending.
class Reveal extends StatefulWidget {
  const Reveal({
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 450),
    this.offset = const Offset(0, 14),
    super.key,
  });

  /// [Reveal]s for a list's items, each [step] after the one before (up to
  /// a few, so a long list doesn't keep the last waiting).
  static List<Widget> staggered(
    List<Widget> children, {
    Duration start = Duration.zero,
    Duration step = const Duration(milliseconds: 45),
  }) => [
    for (final (i, child) in children.indexed)
      Reveal(delay: start + step * (i < 8 ? i : 8), child: child),
  ];

  final Widget child;
  final Duration delay;
  final Duration duration;

  /// Where it starts from, in logical pixels (x follows the reading
  /// direction: positive is towards the end).
  final Offset offset;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.delay + widget.duration,
  );
  late final Animation<double> _progress = CurvedAnimation(
    parent: _controller,
    curve: Interval(
      widget.delay.inMicroseconds /
          (widget.delay + widget.duration).inMicroseconds,
      1,
      curve: Motion.curve,
    ),
  );
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (Motion.reduced(context)) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return AnimatedBuilder(
      animation: _progress,
      child: widget.child,
      builder: (context, child) {
        // The same widgets at rest as in motion, so the child keeps its
        // state when the animation ends.
        final t = _progress.value;
        final dx = widget.offset.dx * (rtl ? -1 : 1);
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(dx, widget.offset.dy) * (1 - t),
            child: child,
          ),
        );
      },
    );
  }
}

/// Pages rise gently into place as they fade in — calmer than Material's
/// default slide or zoom.
class SoftRisePageTransitionsBuilder extends PageTransitionsBuilder {
  const SoftRisePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (Motion.reduced(context)) return child;
    final curved = CurvedAnimation(
      parent: animation,
      curve: Motion.curve,
      reverseCurve: Curves.easeInCubic,
    );
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.03),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}
