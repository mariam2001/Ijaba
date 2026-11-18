import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ijaba/core/components/app_tab_bar.dart';
import 'package:ijaba/core/components/motion.dart';

/// Frame of the four main tabs. go_router keeps each tab's screen alive
/// (an IndexedStack), so switching tabs doesn't reset them; the new tab
/// fades in. (The status-bar icons come from the theme: `_StatusBar`.)
class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: _TabFade(
      index: navigationShell.currentIndex,
      child: navigationShell,
    ),
    bottomNavigationBar: AppTabBar(
      index: navigationShell.currentIndex,
      onSelect: (index) => navigationShell.goBranch(
        index,
        // Tapping the current tab again returns it to its first screen.
        initialLocation: index == navigationShell.currentIndex,
      ),
    ),
  );
}

/// Fades [child] up from half-visible whenever [index] changes. The child
/// itself is never rebuilt from scratch, so each tab keeps its state.
class _TabFade extends StatefulWidget {
  const _TabFade({required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  State<_TabFade> createState() => _TabFadeState();
}

class _TabFadeState extends State<_TabFade>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Motion.medium,
    value: 1,
  );
  late final Animation<double> _opacity = Tween<double>(
    begin: 0.4,
    end: 1,
  ).animate(CurvedAnimation(parent: _controller, curve: Motion.curve));

  @override
  void didUpdateWidget(_TabFade old) {
    super.didUpdateWidget(old);
    if (old.index != widget.index && !Motion.reduced(context)) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      FadeTransition(opacity: _opacity, child: widget.child);
}
