/// The kinds of window the app alerts for.
enum DuaWindowType {
  /// From two-thirds of the way from Maghrib to the next Fajr, until Fajr.
  lastThirdOfNight,

  /// From the adhan until the iqama — Fajr and Maghrib only.
  adhanToIqama,

  /// Right after each obligatory prayer.
  afterPrayer,

  /// Friday's hour of response: the last hour before Maghrib.
  fridayHour,

  /// Fajr until sunrise.
  morningAdhkar,

  /// Asr until Maghrib.
  eveningAdhkar,
}
