import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Type scale, sized with ScreenUtil — read only below `ScreenUtilInit`.
/// Colors come from the active theme.
abstract final class AppTextStyles {
  static TextTheme get textTheme => TextTheme(
    headlineMedium: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16.sp),
    bodyMedium: TextStyle(fontSize: 14.sp),
    bodySmall: TextStyle(fontSize: 12.sp),
    labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
  );
}
