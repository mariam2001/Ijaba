import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/components/branch_ornament.dart';
import 'package:ijaba/core/components/ijaba_mark.dart';
import 'package:ijaba/features/onboarding/presentation/widgets/onboarding_layout.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) => OnboardingLayout(
    step: 0,
    action: FilledButton(
      onPressed: () => context.go(AppRoutes.location),
      child: Text(context.tr(LocaleKeys.welcome_start)),
    ),
    children: [
      SizedBox(height: 40.h),
      Center(
        child: Container(
          width: 168.r,
          height: 168.r,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.greenPale,
            shape: BoxShape.circle,
          ),
          child: IjabaMark(width: 57.r, color: AppColors.green),
        ),
      ),
      SizedBox(height: 24.h),
      Center(
        child: BranchOrnament(
          width: 118.r,
          color: AppColors.greenMid.withValues(alpha: 0.45),
        ),
      ),
      SizedBox(height: 64.h),
      Text(
        context.tr(LocaleKeys.welcome_title),
        textAlign: TextAlign.center,
        style: AppTextStyles.heroTitleFor(context.locale),
      ),
      SizedBox(height: 14.h),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Text(
          context.tr(LocaleKeys.welcome_body),
          textAlign: TextAlign.center,
          style: AppTextStyles.lead,
        ),
      ),
    ],
  );
}
