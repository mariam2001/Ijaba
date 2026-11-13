import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// One choice in [showOptionSheet]: its value, label and an optional hint.
typedef SheetOption<T> = ({T value, String label, String? hint});

/// A bottom sheet to pick one of [options]; the current one is ticked.
/// Resolves to the picked value, or null if dismissed. (No design yet —
/// styled like the app's cards.)
Future<T?> showOptionSheet<T>({
  required BuildContext context,
  required String title,
  required List<SheetOption<T>> options,
  required T selected,
}) => showAppSheet<T>(
  context: context,
  title: title,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (final option in options)
        Builder(
          builder: (context) => InkWell(
            onTap: () => Navigator.pop(context, option.value),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 13.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(option.label, style: AppTextStyles.listCardTitle),
                        if (option.hint case final hint?)
                          Text(hint, style: AppTextStyles.listCardCaption),
                      ],
                    ),
                  ),
                  if (option.value == selected)
                    Icon(
                      LucideIcons.check300,
                      size: 20.r,
                      color: AppColors.green,
                    ),
                ],
              ),
            ),
          ),
        ),
    ],
  ),
);

/// The app's bottom sheet: paper, a title, and [child]; scrolls when long.
Future<T?> showAppSheet<T>({
  required BuildContext context,
  required String title,
  required Widget child,
}) => showModalBottomSheet<T>(
  context: context,
  // Over the tab bar too, not just the tab's own screen.
  useRootNavigator: true,
  isScrollControlled: true,
  backgroundColor: AppColors.paper,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
  ),
  builder: (context) => ConstrainedBox(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.8,
    ),
    child: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20.h, bottom: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Text(title, style: AppTextStyles.sectionTitle),
            ),
            SizedBox(height: 8.h),
            child,
          ],
        ),
      ),
    ),
  ),
);
