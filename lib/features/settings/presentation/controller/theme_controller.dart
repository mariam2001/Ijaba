import 'package:flutter/material.dart';
import 'package:ijaba/core/controllers/clock_controller.dart';
import 'package:ijaba/core/service/local/cache/simple_cache.dart';
import 'package:ijaba/core/utils/enums.dart';
import 'package:ijaba/features/prayer_times/data/datasource/prayer_times_calculator.dart';
import 'package:ijaba/features/prayer_times/data/model/prayer.dart';
import 'package:ijaba/features/prayer_times/presentation/controller/prayer_times_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_controller.g.dart';

/// How the app picks its day or night palette (Settings → Night mode).
enum ThemePreference {
  /// The phone's dark-mode setting (the default).
  system,

  /// Night from Maghrib until sunrise, by today's prayer times.
  afterMaghrib,
  light,
  dark,
}

/// The saved [ThemePreference].
@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  @override
  ThemePreference build() {
    final saved = ref.watch(SimpleCache.provider).read(CacheKey.themeMode);
    return ThemePreference.values.asNameMap()[saved] ?? ThemePreference.system;
  }

  Future<void> setPreference(ThemePreference preference) async {
    state = preference;
    await ref
        .read(SimpleCache.provider)
        .write(CacheKey.themeMode, preference.name);
  }
}

/// The [ThemeMode] the app runs in. "After Maghrib" follows the clock, so
/// the app turns night at Maghrib while it's open; before a location is
/// set (no prayer times yet) it follows the phone.
@Riverpod(keepAlive: true)
ThemeMode themeMode(Ref ref) => switch (ref.watch(themeControllerProvider)) {
  ThemePreference.system => ThemeMode.system,
  ThemePreference.light => ThemeMode.light,
  ThemePreference.dark => ThemeMode.dark,
  ThemePreference.afterMaghrib => _afterMaghrib(ref),
};

ThemeMode _afterMaghrib(Ref ref) {
  final location = ref.watch(prayerLocationProvider);
  if (location == null) return ThemeMode.system;
  final settings = ref.watch(prayerSettingsProvider);
  final now = ref.watch(clockProvider).value ?? DateTime.now();
  try {
    final today = const PrayerTimesCalculator().calculate(
      date: DateTime(now.year, now.month, now.day),
      location: location,
      settings: settings,
    );
    final night =
        now.isBefore(today.sunrise) ||
        !now.isBefore(today.adhan(Prayer.maghrib));
    return night ? ThemeMode.dark : ThemeMode.light;
  } on Object {
    return ThemeMode.system; // Polar latitudes: no Maghrib to go by.
  }
}
