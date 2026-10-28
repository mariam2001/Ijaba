import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:ijaba/core/utils/localized_digits.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// When a window's alert fires: "تنبيه قبل ٥ دقائق" / "5 min before", or
/// "at the start" when it has no lead time.
String alertTimingText(BuildContext context, Duration leadTime) {
  final minutes = leadTime.inMinutes;
  if (minutes == 0) return context.tr(LocaleKeys.home_alert_at_start);
  return context.tr(
    LocaleKeys.home_alert_before,
    namedArgs: {
      'minutes': context.plural(
        LocaleKeys.home_minutes,
        minutes,
        args: [localizedDigits(minutes, context.locale.languageCode)],
      ),
    },
  );
}
