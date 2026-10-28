import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ijaba/config/themes/app_colors.dart';
import 'package:ijaba/config/themes/app_text_styles.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/features/windows/presentation/alert_toggles.dart';
import 'package:ijaba/features/windows/presentation/controller/enabled_windows_controller.dart';
import 'package:ijaba/features/windows/presentation/widgets/alert_toggle_row.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Alert control: which windows reach the user. Changes are saved at once
/// and the alerts re-planned (see `_AlertScheduler` in app.dart).
class WindowsPage extends ConsumerWidget {
  const WindowsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(enabledWindowTypesProvider);
    final on = AlertToggle.values.where((t) => t.isOnIn(enabled)).length;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        // The footnote sits at the bottom when the list leaves room, and
        // after the list on short screens.
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(22.w, 33.h, 22.w, 0),
              sliver: SliverList.list(
                children: [
                  Text(
                    context.tr(LocaleKeys.alert_control_title),
                    style: AppTextStyles.screenTitleFor(context.locale),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    context.tr(LocaleKeys.alert_control_subtitle),
                    style: AppTextStyles.subtitle.copyWith(fontSize: 12.sp),
                  ),
                  SizedBox(height: 18.h),
                  _AlertsOnChip(on: on, total: AlertToggle.values.length),
                  SizedBox(height: 10.h),
                  for (final toggle in AlertToggle.values)
                    AlertToggleRow(
                      toggle: toggle,
                      on: toggle.isOnIn(enabled),
                      onChanged: (value) => ref
                          .read(enabledWindowTypesProvider.notifier)
                          .setEnabled(toggle.types, on: value),
                    ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(22.w, 24.h, 22.w, 14.h),
                child: Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: Text(
                    context.tr(LocaleKeys.alert_control_footer),
                    style: AppTextStyles.footnote,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "4 of 6 alerts on … 4 / 6".
class _AlertsOnChip extends StatelessWidget {
  const _AlertsOnChip({required this.on, required this.total});

  final int on;
  final int total;

  @override
  Widget build(BuildContext context) {
    final language = context.locale.languageCode;
    final counts = {
      'on': localizedDigits(on, language),
      'total': localizedDigits(total, language),
    };
    return Container(
      height: 34.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: AppColors.greenPale,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.tr(LocaleKeys.alert_control_alerts_on, namedArgs: counts),
              style: AppTextStyles.chipLabel,
            ),
          ),
          Text(
            context.tr(LocaleKeys.alert_control_count, namedArgs: counts),
            style: AppTextStyles.chipValue,
          ),
        ],
      ),
    );
  }
}
