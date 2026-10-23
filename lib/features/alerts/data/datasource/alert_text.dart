import 'package:easy_localization/easy_localization.dart';
import 'package:ijaba/features/alerts/data/model/planned_alert.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/windows/data/model/dua_window.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
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

  /// The heads-up before the last third says when it begins; every other
  /// alert fires as its window opens and says until when it stays open.
  String body(PlannedAlert alert) {
    final window = alert.windows.first;
    return window.type == DuaWindowType.lastThirdOfNight
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
      namedArgs: {'prayer': translate(_prayerKey(prayer))},
    ),
    (DuaWindowType.afterPrayer, final Prayer prayer) => translate(
      LocaleKeys.alerts_after_prayer_of,
      namedArgs: {'prayer': translate(_prayerKey(prayer))},
    ),
    (final type, _) => translate(_windowKey(type)),
  };

  String _windowKey(DuaWindowType type) => switch (type) {
    DuaWindowType.lastThirdOfNight => LocaleKeys.windows_last_third,
    DuaWindowType.adhanToIqama => LocaleKeys.windows_adhan_to_iqama,
    DuaWindowType.afterPrayer => LocaleKeys.windows_after_prayer,
    DuaWindowType.fridayHour => LocaleKeys.windows_friday_hour,
    DuaWindowType.morningAdhkar => LocaleKeys.windows_morning_adhkar,
    DuaWindowType.eveningAdhkar => LocaleKeys.windows_evening_adhkar,
  };

  String _prayerKey(Prayer prayer) => switch (prayer) {
    Prayer.fajr => LocaleKeys.prayers_fajr,
    Prayer.dhuhr => LocaleKeys.prayers_dhuhr,
    Prayer.asr => LocaleKeys.prayers_asr,
    Prayer.maghrib => LocaleKeys.prayers_maghrib,
    Prayer.isha => LocaleKeys.prayers_isha,
  };
}
