import 'package:ijaba/core/components/app_icon.dart';
import 'package:ijaba/features/windows/data/model/dua_window_type.dart';

/// Each window's line icon (rows, switches).
AppIcon windowIcon(DuaWindowType type) => switch (type) {
  DuaWindowType.lastThirdOfNight => AppIcon.lastThird,
  DuaWindowType.adhanToIqama => AppIcon.adhanIqama,
  DuaWindowType.afterPrayer => AppIcon.afterPrayer,
  DuaWindowType.fridayHour => AppIcon.fridayHour,
  DuaWindowType.morningAdhkar => AppIcon.morning,
  DuaWindowType.eveningAdhkar => AppIcon.evening,
};

/// Each window's illustration for the Home hero card: multicolour art drawn
/// for the green card, never tinted.
String windowIllustration(DuaWindowType type) {
  final name = switch (type) {
    DuaWindowType.lastThirdOfNight => 'last_third',
    DuaWindowType.adhanToIqama => 'adhan',
    DuaWindowType.afterPrayer => 'after_prayer',
    DuaWindowType.fridayHour => 'friday',
    DuaWindowType.morningAdhkar => 'morning',
    DuaWindowType.eveningAdhkar => 'evening',
  };
  return 'assets/illustrations/hero_$name.svg';
}
