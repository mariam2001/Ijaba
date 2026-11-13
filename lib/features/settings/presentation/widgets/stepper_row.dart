import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// A label (and optional caption) with − value + steppers. A null [onMinus]
/// or [onPlus] disables that step (at the limit).
class StepperRow extends StatelessWidget {
  const StepperRow({
    required this.label,
    required this.value,
    required this.onMinus,
    required this.onPlus,
    this.caption,
    super.key,
  });

  final String label;
  final Widget? caption;
  final String value;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;

  @override
  Widget build(BuildContext context) {
    final caption = this.caption;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.listCardTitle),
                ?caption,
              ],
            ),
          ),
          _Step(icon: LucideIcons.minus300, label: '−', onTap: onMinus),
          SizedBox(
            width: 44.w,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: AppTextStyles.rowTime,
            ),
          ),
          _Step(icon: LucideIcons.plus300, label: '+', onTap: onPlus),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onTap,
    tooltip: label,
    style: IconButton.styleFrom(
      backgroundColor: AppColors.paperSoft,
      side: const BorderSide(color: AppColors.line),
    ),
    icon: Icon(icon, size: 18.r, color: AppColors.green),
  );
}
