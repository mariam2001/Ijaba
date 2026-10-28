import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Back · where you are ("Last third of the night", "3:12 AM · 2 of 7") ·
/// save.
class DuaHeader extends StatelessWidget {
  const DuaHeader({
    required this.title,
    required this.now,
    required this.position,
    required this.total,
    required this.saved,
    required this.onBack,
    required this.onToggleSaved,
    super.key,
  });

  final String title;
  final DateTime now;

  /// 1-based.
  final int position;
  final int total;
  final bool saved;
  final VoidCallback onBack;
  final VoidCallback onToggleSaved;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    final time = DateFormat(
      language == 'ar' ? 'h:mm' : 'h:mm a',
      language,
    ).format(now);
    final of = context.tr(
      LocaleKeys.dua_position,
      namedArgs: {
        'index': localizedDigits(position, language),
        'total': localizedDigits(total, language),
      },
    );

    return Row(
      children: [
        _EdgeIcon(
          icon: LucideIcons.chevronLeft300Dir,
          label: MaterialLocalizations.of(context).backButtonTooltip,
          color: AppColors.muted,
          onTap: onBack,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.contextTitle,
              ),
              SizedBox(height: 3.h),
              Text(
                '${localizedNumerals(time, language)} · $of',
                style: AppTextStyles.contextSubtitle,
              ),
            ],
          ),
        ),
        _EdgeIcon(
          icon: saved ? LucideIcons.bookmarkCheck300 : LucideIcons.bookmark300,
          label: context.tr(
            saved ? LocaleKeys.dua_unsave : LocaleKeys.dua_save,
          ),
          color: saved ? AppColors.green : AppColors.muted,
          onTap: onToggleSaved,
          end: true,
        ),
      ],
    );
  }
}

/// A header icon whose glyph sits on the content edge, as in the design;
/// the touch target extends inward instead.
class _EdgeIcon extends StatelessWidget {
  const _EdgeIcon({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.end = false,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  /// At the end edge (the touch target extends towards the start).
  final bool end;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    excludeSemantics: true,
    child: GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: end ? 16.w : 0,
          end: end ? 0 : 16.w,
          top: 12.h,
          bottom: 12.h,
        ),
        child: Icon(icon, size: 20.r, color: color),
      ),
    ),
  );
}
