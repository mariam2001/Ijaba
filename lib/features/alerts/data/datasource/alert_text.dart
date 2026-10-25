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

  String title(PlannedAlert alert) => alert.windows.map(_label).join(' · ');

  /// A heads-up (fired before the window opens) says when it begins; an
  /// alert fired as the window opens says until when it stays open.
  String body(PlannedAlert alert) {
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
