import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// The bar of a page pushed over the tabs (My duas, the dua editor): a
/// Lucide back chevron — Material's own back arrow would break the icon
/// set — the title, and [actions].
class PageBar extends StatelessWidget implements PreferredSizeWidget {
  const PageBar({required this.title, this.actions = const [], super.key});

  final String title;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
    // No tint when content scrolls under it.
    scrolledUnderElevation: 0,
    leading: IconButton(
      onPressed: () => context.pop(),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      icon: Icon(
        LucideIcons.chevronLeft300Dir,
        size: 24.r,
        color: context.colors.ink,
      ),
    ),
    title: Text(title, style: context.textStyles.cardTitle),
    actions: [
      ...actions,
      SizedBox(width: 8.w),
    ],
  );
}
