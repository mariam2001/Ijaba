import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/core/components/ijaba_logo.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/features/home/presentation/controller/home_greeting_controller.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// The warm Home's header (Figma ١٦): a greeting for the time of day
/// ("ليلتك مباركة"), today's date ("الخميس ١٩ نوفمبر") and the logo.
class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.now, required this.greeting, super.key});

  final DateTime now;
  final HomeGreeting greeting;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    final local = now.toLocal();
    final date = context.tr(
      LocaleKeys.home_warm_date,
      namedArgs: {
        'weekday': DateFormat.EEEE(language).format(local),
        'day': localizedDigits(local.day, language),
        'month': DateFormat.MMMM(language).format(local),
      },
    );

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // A new greeting (the day turning) cross-fades in.
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                layoutBuilder: (current, previous) => Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [...previous, ?current],
                ),
                child: Text(
                  context.tr(greeting.key),
                  key: ValueKey(greeting),
                  style: context.textStyles.greeting,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                date,
                style: context.textStyles.caption.copyWith(
                  fontSize: 12.sp,
                  color: context.colors.muted,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        IjabaLogo(size: 30.r),
      ],
    );
  }
}
