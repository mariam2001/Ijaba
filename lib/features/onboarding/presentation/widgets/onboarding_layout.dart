import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/core/components/page_dots.dart';

/// Frame shared by the onboarding screens: [children] from the top (they
/// scroll on short phones), with the step dots, the [action] button and an
/// optional [footer] pinned to the bottom.
class OnboardingLayout extends StatelessWidget {
  const OnboardingLayout({
    required this.children,
    required this.action,
    this.step,
    this.footer,
    this.footerSpacing,
    this.bottomSpacing,
    super.key,
  });

  final List<Widget> children;
  final Widget action;

  /// 0-based position in the three-step progress; no dots when null.
  final int? step;
  final Widget? footer;

  /// Gaps above the footer and below the last element, when a footer
  /// brings its own padding (e.g. a text button).
  final double? footerSpacing;
  final double? bottomSpacing;

  @override
  Widget build(BuildContext context) {
    final step = this.step;
    final footer = this.footer;
    // Dark status-bar icons on the paper background (the splash sets light).
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: children,
                    ),
                  ),
                ),
                if (step != null) ...[
                  Center(child: PageDots(count: 3, index: step)),
                  SizedBox(height: footer == null ? 22.h : 16.h),
                ],
                action,
                if (footer != null) ...[
                  SizedBox(height: footerSpacing ?? 17.h),
                  footer,
                ],
                SizedBox(
                  height: bottomSpacing ?? (footer == null ? 38.h : 39.h),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
