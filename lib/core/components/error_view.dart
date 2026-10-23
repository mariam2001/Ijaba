import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ijaba/core/error/failure.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Full-area error message for an `AsyncValue` error, with optional retry.
class ErrorView extends StatelessWidget {
  const ErrorView({required this.error, this.onRetry, super.key});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final message = switch (error) {
      Failure(:final message) => message,
      _ => context.tr(LocaleKeys.errors_unknown),
    };
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.r,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 12.h),
            Text(message, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              SizedBox(height: 16.h),
              OutlinedButton(
                onPressed: onRetry,
                child: Text(context.tr(LocaleKeys.common_retry)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
