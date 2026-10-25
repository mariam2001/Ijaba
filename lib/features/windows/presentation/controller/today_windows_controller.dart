import 'package:ijaba/core/controllers/clock_controller.dart';
import 'package:ijaba/features/prayer_times/data/datasource/prayer_times_calculator.dart';
import 'package:ijaba/features/prayer_times/presentation/controller/prayer_times_controller.dart';
import 'package:ijaba/features/windows/data/model/today_windows.dart';
import 'package:ijaba/features/windows/presentation/controller/enabled_windows_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'today_windows_controller.g.dart';

/// The windows for Home, recomputed on every clock tick (cheap: three days
/// of prayer times) and whenever the location or settings change. Fails with
/// `CalculationFailure` where prayer times can't be computed.
@riverpod
Future<TodayWindows> todayWindows(Ref ref) async {
  final now = ref.watch(clockProvider).value ?? DateTime.now();
  final location = ref.watch(prayerLocationProvider);
  if (location == null) return const TodayWindows(windows: []);
  final settings = ref.watch(prayerSettingsProvider);

  const calculator = PrayerTimesCalculator();
  return TodayWindows.at(
    now,
    days: [
      for (var offset = -1; offset <= 1; offset++)
        calculator.calculate(
          date: DateTime(now.year, now.month, now.day + offset),
          location: location,
          settings: settings,
        ),
    ],
    enabled: ref.watch(enabledWindowTypesProvider),
  );
}
