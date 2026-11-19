/// Keys for `SimpleCache`; the enum name is the stored key.
enum CacheKey {
  themeMode,
  alarmMode,
  location,
  onboardingDone,
  enabledWindows,
  savedDuas,
  prayerSettings,
  windowConfig,
  customDuas,
  reminderIndex,
  welcomePending,
  // Dates per window, from the first version: folded into duaDays, then
  // removed.
  completions,
  duaDays,
}
