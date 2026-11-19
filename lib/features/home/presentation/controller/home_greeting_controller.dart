import 'package:ijaba/core/controllers/clock_controller.dart';
import 'package:ijaba/features/prayer_times/data/datasource/prayer_times_calculator.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer_day.dart';
import 'package:ijaba/features/prayer_times/presentation/controller/prayer_times_controller.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/features/windows/presentation/controller/today_windows_controller.dart';
import 'package:ijaba/generated/locale_keys.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_greeting_controller.g.dart';

/// Home's greeting, by the time of day (Figma "Warm moments").
enum HomeGreeting {
  afterFajr(LocaleKeys.greeting_after_fajr),
  midday(LocaleKeys.greeting_midday),
  afterAsr(LocaleKeys.greeting_after_asr),
  afterMaghrib(LocaleKeys.greeting_after_maghrib),
  lastThird(LocaleKeys.greeting_last_third),
  friday(LocaleKeys.greeting_friday)
  ;

  const HomeGreeting(this.key);

  /// Its text's translation key.
  final String key;

  /// The greeting at [now]: the last third of the night first, then Friday
  /// (from Fajr to Maghrib), then the part of the day [today]'s prayers
  /// mark. Before today's Fajr it's still the evening.
  static HomeGreeting at(
    DateTime now, {
    required PrayerDay today,
    required bool lastThird,
  }) {
    if (lastThird) return HomeGreeting.lastThird;
    bool from(Prayer prayer) => !now.isBefore(today.adhan(prayer));
    if (!from(Prayer.fajr) || from(Prayer.maghrib)) {
      return HomeGreeting.afterMaghrib;
    }
    if (now.toLocal().weekday == DateTime.friday) return HomeGreeting.friday;
    if (from(Prayer.asr)) return HomeGreeting.afterAsr;
    if (from(Prayer.dhuhr)) return HomeGreeting.midday;
    return HomeGreeting.afterFajr;
  }

  /// Without prayer times (no location yet, or the polar summer): by the
  /// clock.
  static HomeGreeting byClock(DateTime now) {
    final local = now.toLocal();
    return switch (local.hour) {
      >= 4 && < 12 => HomeGreeting.afterFajr,
      >= 12 && < 15 => HomeGreeting.midday,
      >= 15 && < 18 => HomeGreeting.afterAsr,
      _ => HomeGreeting.afterMaghrib,
    };
  }
}

/// The greeting now; recomputed on each clock tick.
@riverpod
HomeGreeting homeGreeting(Ref ref) {
  final now = ref.watch(clockProvider).value ?? DateTime.now();
  final lastThird =
      ref
          .watch(todayWindowsProvider)
          .value
          ?.windows
          .any(
            (window) =>
                window.type == DuaWindowType.lastThirdOfNight &&
                window.isOpenAt(now),
          ) ??
      false;
  if (lastThird) return HomeGreeting.lastThird;
  final location = ref.watch(prayerLocationProvider);
  if (location == null) return HomeGreeting.byClock(now);
  try {
    final local = now.toLocal();
    final today = const PrayerTimesCalculator().calculate(
      date: DateTime(local.year, local.month, local.day),
      location: location,
      settings: ref.watch(prayerSettingsProvider),
    );
    return HomeGreeting.at(now, today: today, lastThird: lastThird);
  } on Object {
    return HomeGreeting.byClock(now);
  }
}
