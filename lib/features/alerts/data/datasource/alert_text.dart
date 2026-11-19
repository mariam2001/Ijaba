import 'package:easy_localization/easy_localization.dart';
import 'package:ijaba/features/alerts/data/model/planned_alert.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/windows/data/model/dua_window.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/presentation/window_names.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

typedef Translate =
    String Function(String key, {Map<String, String>? namedArgs});

/// Builds a notification's title and body. Translation and time formatting
/// are injected so the wording can be unit-tested.
class AlertText {
  const AlertText({required this.translate, required this.formatTime});

  /// The app's wiring: easy_localization strings and the locale's clock
  /// format (e.g. "٢:٤١ ص" in Arabic, "2:41 AM" in English).
  factory AlertText.forLocale(String localeName) => AlertText(
    translate: (key, {namedArgs}) => key.tr(namedArgs: namedArgs),
    formatTime: (instant) =>
        DateFormat.jm(localeName).format(instant.toLocal()),
  );

  final Translate translate;
  final String Function(DateTime instant) formatTime;

  String title(PlannedAlert alert) => switch (_warm(alert)) {
    DuaWindowType.lastThirdOfNight => translate(
      _isHeadsUp(alert)
          ? LocaleKeys.warm_alerts_last_third_soon_title
          : LocaleKeys.warm_alerts_last_third_title,
    ),
    DuaWindowType.fridayHour => translate(LocaleKeys.warm_alerts_friday_title),
    DuaWindowType.morningAdhkar => translate(
      LocaleKeys.warm_alerts_morning_title,
    ),
    _ => alert.windows.map(_label).join(' · '),
  };

  /// The windows with the design's warm wording (Figma ١٧), when an alert
  /// is for one of them alone; others keep the plain "name · time".
  DuaWindowType? _warm(PlannedAlert alert) {
    if (alert.windows.length != 1) return null;
    final type = alert.windows.single.type;
    return switch (type) {
      DuaWindowType.lastThirdOfNight ||
      DuaWindowType.fridayHour ||
      DuaWindowType.morningAdhkar => type,
      _ => null,
    };
  }

  /// Fired before its window opens (the last third's comes 15 minutes
  /// early): "it's near" rather than "it has begun".
  bool _isHeadsUp(PlannedAlert alert) =>
      alert.windows.first.start.isAfter(alert.at);

  /// The warm windows' own words; otherwise a heads-up (fired before the
  /// window opens) says when it begins, and an alert fired as the window
  /// opens says until when it stays open.
  String body(PlannedAlert alert) {
    switch (_warm(alert)) {
      case DuaWindowType.lastThirdOfNight:
        return translate(LocaleKeys.warm_alerts_last_third_body);
      case DuaWindowType.fridayHour:
        return translate(LocaleKeys.warm_alerts_friday_body);
      case DuaWindowType.morningAdhkar:
        return translate(LocaleKeys.warm_alerts_morning_body);
      case _:
    }
    final window = alert.windows.first;
    return window.start.isAfter(alert.at)
        ? translate(
            LocaleKeys.alerts_begins_at,
            namedArgs: {'time': formatTime(window.start)},
          )
        : translate(
            LocaleKeys.alerts_open_until,
            namedArgs: {'time': formatTime(window.end)},
          );
  }

  String _label(DuaWindow window) => switch ((window.type, window.prayer)) {
    (DuaWindowType.adhanToIqama, final Prayer prayer) => translate(
      LocaleKeys.alerts_adhan_to_iqama_of,
      namedArgs: {'prayer': translate(prayerNameKey(prayer))},
    ),
    (DuaWindowType.afterPrayer, final Prayer prayer) => translate(
      LocaleKeys.alerts_after_prayer_of,
      namedArgs: {'prayer': translate(prayerNameKey(prayer))},
    ),
    (final type, _) => translate(windowNameKey(type)),
  };
}
