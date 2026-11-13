import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// A labelled group of [SettingsRow]s on one card, ruled between rows.
class SettingsSection extends StatelessWidget {
  const SettingsSection({required this.label, required this.rows, super.key});

  final String label;
  final List<SettingsRow> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.sectionLabel),
        SizedBox(height: 7.h),
        Material(
          color: AppColors.paperSoft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
            side: const BorderSide(color: AppColors.line),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (final (i, row) in rows.indexed) ...[
                if (i > 0) const Divider(height: 1, color: AppColors.line),
                row,
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// A setting: its name, current value, and a chevron. Null [onTap] shows it
/// muted and inert (not available yet).
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    required this.title,
    required this.value,
    required this.onTap,
    super.key,
  });

  final String title;
  final String? value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final value = this.value;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(17.w, 14.25.h, 14.w, 14.25.h),
        // The name at the start (wrapping if it must); the value hugs the
        // chevron at the end, capped so a long one (a method's full name)
        // is cut short rather than crowding the name.
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.listCardTitle.copyWith(
                  color: enabled ? AppColors.ink : AppColors.muted,
                ),
              ),
            ),
            if (value != null) ...[
              SizedBox(width: 16.w),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 170.w),
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.settingsValue,
                ),
              ),
            ],
            SizedBox(width: 8.w),
            Icon(
              LucideIcons.chevronRight300Dir,
              size: 20.r,
              color: AppColors.faint,
            ),
          ],
        ),
      ),
    );
  }
}
