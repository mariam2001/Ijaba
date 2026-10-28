import 'package:ijaba/features/windows/data/model/dua_window_type.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// The switches on the Windows screen, in order. Morning and evening adhkar
/// share one, as in the design. The design's sixth switch, "when it rains",
/// is left out of v1: it would need a weather service to know the location.
enum AlertToggle {
  lastThird(LocaleKeys.windows_last_third, {DuaWindowType.lastThirdOfNight}),
  adhanToIqama(LocaleKeys.windows_adhan_to_iqama, {
    DuaWindowType.adhanToIqama,
  }),
  afterPrayer(LocaleKeys.alert_control_after_prayers, {
    DuaWindowType.afterPrayer,
  }),
  fridayHour(LocaleKeys.alert_control_friday_hour, {DuaWindowType.fridayHour}),
  adhkar(LocaleKeys.alert_control_adhkar, {
    DuaWindowType.morningAdhkar,
    DuaWindowType.eveningAdhkar,
  })
  ;

  const AlertToggle(this.titleKey, this.types);

  final String titleKey;

  /// The windows this switch turns on or off.
  final Set<DuaWindowType> types;

  bool isOnIn(Set<DuaWindowType> enabled) => enabled.containsAll(types);
}
