import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/app_icon.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Bottom navigation of the main screens: Home · Duas · Windows · Settings.
class AppTabBar extends StatelessWidget {
  const AppTabBar({required this.index, required this.onSelect, super.key});

  final int index;
  final ValueChanged<int> onSelect;

  // 1.5-stroke line icons: Lucide's "300" variants, and the app's own
  // hands for Duas.
  static final _tabs = <(Widget Function(Color color), String)>[
    (_lucide(LucideIcons.house300), LocaleKeys.tabs_home),
    (
      (color) => AppIconView(AppIcon.duaHands, size: 20.r, color: color),
      LocaleKeys.tabs_duas,
    ),
    (_lucide(LucideIcons.clock300), LocaleKeys.tabs_windows),
    (_lucide(LucideIcons.settings300), LocaleKeys.tabs_settings),
  ];

  static Widget Function(Color color) _lucide(IconData icon) =>
      (color) => Icon(icon, size: 20.r, color: color);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.paperSoft,
        border: Border(top: BorderSide(color: context.colors.line)),
      ),
      child: Padding(
        // 20 below the labels in the design; more if the system needs it.
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: bottomInset > 20.h ? bottomInset : 20.h,
        ),
        child: Row(
          children: [
            for (final (i, (icon, label)) in _tabs.indexed)
              Expanded(
                child: _TabItem(
                  icon: icon,
                  label: context.tr(label),
                  selected: i == index,
                  onTap: () => onSelect(i),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  /// Draws the tab's icon in the given colour.
  final Widget Function(Color color) icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? context.colors.greenInk : context.colors.faint;
    return Semantics(
      selected: selected,
      button: true,
      child: InkResponse(
        onTap: onTap,
        radius: 32.r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon(color),
            SizedBox(height: 5.h),
            Text(
              label,
              style: context.textStyles.tabLabel.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
