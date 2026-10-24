import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/routes/app_routes.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/components/branch_ornament.dart';
import 'package:ijaba/core/components/ijaba_mark.dart';
import 'package:ijaba/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  static const duration = Duration(milliseconds: 1800);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      final timer = Future<void>.delayed(duration, () {
        if (!context.mounted) return;
        final onboarded = ref.read(onboardingControllerProvider);
        context.go(onboarded ? AppRoutes.home : AppRoutes.language);
      });
      return timer.ignore;
    }, const []);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.green,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            // Free space is split in the Figma frame's proportions, so the
            // layout matches it at 390 × 844 and compresses on short phones.
            child: Column(
              children: [
                const Spacer(flex: 255),
                IjabaMark(
                  width: 68.r,
                  color: AppColors.paper,
                ),
                SizedBox(height: 27.h),
                Text(
                  context.tr(LocaleKeys.app_name),
                  style: AppTextStyles.wordmark.copyWith(
                    color: AppColors.paper,
                  ),
                ),
                Text(
                  context.tr(LocaleKeys.app_latin_name),
                  style: AppTextStyles.subtitle.copyWith(
                    fontSize: 12.sp,
                    letterSpacing: 3.8.sp,
                    color: AppColors.greenPale,
                  ),
                ),
                SizedBox(height: 25.h),
                BranchOrnament(
                  width: 146.r,
                  color: AppColors.greenPale.withValues(alpha: 0.45),
                ),
                const Spacer(flex: 276),
                Text(
                  context.tr(LocaleKeys.splash_verse),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.dua.copyWith(
                    fontSize: 17.sp,
                    color: AppColors.greenPale,
                  ),
                ),
                SizedBox(height: 51.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
