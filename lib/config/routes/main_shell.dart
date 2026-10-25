import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ijaba/core/components/app_tab_bar.dart';

/// Frame of the four main tabs. go_router keeps each tab's screen alive
/// (an IndexedStack), so switching tabs doesn't reset them.
class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.dark,
    child: Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppTabBar(
        index: navigationShell.currentIndex,
        onSelect: (index) => navigationShell.goBranch(
          index,
          // Tapping the current tab again returns it to its first screen.
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    ),
  );
}
