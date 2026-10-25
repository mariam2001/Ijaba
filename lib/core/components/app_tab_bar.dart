import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Bottom navigation of the main screens: Home · Duas · Windows · Settings.
class AppTabBar extends StatelessWidget {
  const AppTabBar({required this.index, required this.onSelect, super.key});

  final int index;
  final ValueChanged<int> onSelect;

  // Lucide icons with a 1.5 stroke (the "300" variants), as in the design.
  // The Duas icon is a plain rounded square there — kept as drawn.
  static const _tabs = [
    (LucideIcons.house300, LocaleKeys.tabs_home),
    (LucideIcons.square300, LocaleKeys.tabs_duas),
    (LucideIcons.clock300, LocaleKeys.tabs_windows),
    (LucideIcons.settings300, LocaleKeys.tabs_settings),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.paperSoft,
        border: Border(top: BorderSide(color: AppColors.line)),
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

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.green : AppColors.faint;
    return Semantics(
      selected: selected,
      button: true,
      child: InkResponse(
        onTap: onTap,
        radius: 32.r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20.r, color: color),
            SizedBox(height: 5.h),
            Text(
              label,
              style: AppTextStyles.tabLabel.copyWith(
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
