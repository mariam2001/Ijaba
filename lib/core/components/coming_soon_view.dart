import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Body for tabs whose screens aren't built yet: their name and "coming
/// soon", plus anything in [extra].
class ComingSoonView extends StatelessWidget {
  const ComingSoonView({required this.title, this.extra, super.key});

  final String title;
  final Widget? extra;

  @override
  Widget build(BuildContext context) {
    final extra = this.extra;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: AppTextStyles.screenTitleFor(context.locale)),
              SizedBox(height: 6.h),
              Text(
                context.tr(LocaleKeys.common_coming_soon),
                style: AppTextStyles.subtitle,
              ),
              if (extra != null) ...[SizedBox(height: 24.h), extra],
            ],
          ),
        ),
      ),
    );
  }
}
