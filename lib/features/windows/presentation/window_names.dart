import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Translation keys for window and prayer names, shared by the screens and
/// the notification texts.
String windowNameKey(DuaWindowType type) => switch (type) {
  DuaWindowType.lastThirdOfNight => LocaleKeys.windows_last_third,
  DuaWindowType.adhanToIqama => LocaleKeys.windows_adhan_to_iqama,
  DuaWindowType.afterPrayer => LocaleKeys.windows_after_prayer,
  DuaWindowType.fridayHour => LocaleKeys.windows_friday_hour,
  DuaWindowType.morningAdhkar => LocaleKeys.windows_morning_adhkar,
  DuaWindowType.eveningAdhkar => LocaleKeys.windows_evening_adhkar,
};

String prayerNameKey(Prayer prayer) => switch (prayer) {
  Prayer.fajr => LocaleKeys.prayers_fajr,
  Prayer.dhuhr => LocaleKeys.prayers_dhuhr,
  Prayer.asr => LocaleKeys.prayers_asr,
  Prayer.maghrib => LocaleKeys.prayers_maghrib,
  Prayer.isha => LocaleKeys.prayers_isha,
};
