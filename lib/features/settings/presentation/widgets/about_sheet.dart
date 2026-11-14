import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/config/themes/app_theme_context.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// What Ijaba is, its privacy promise, where the duas come from, and the
/// licences of what it's built with (fonts included).
class AboutSheet extends StatelessWidget {
  const AboutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.tr(LocaleKeys.settings_about_body),
            style: context.textStyles.body,
          ),
          SizedBox(height: 10.h),
          Text(
            context.tr(LocaleKeys.settings_about_sources),
            style: context.textStyles.body,
          ),
          SizedBox(height: 8.h),
          TextButton(
            onPressed: () => showLicensePage(
              context: context,
              applicationName: context.tr(LocaleKeys.app_name),
            ),
            child: Text(context.tr(LocaleKeys.settings_licenses)),
          ),
        ],
      ),
    );
  }
}
