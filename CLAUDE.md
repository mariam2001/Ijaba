# Ijaba — project context

Dua reminder app: alerts at the times dua is most likely accepted, plus athkar
and prayer reminders. **The spec is `docs/HANDOVER.md` — read it first.** (Its
`assets/` folder lives in `branding/` here.) Follows
`~/.claude/flutter-architecture-blueprint.md`, except where this file differs.

## Non-negotiables (from the handover)
- **Never invent or guess hadith references / dua sources.** Use a visible
  placeholder ("[verify attribution before release]"); Mariam verifies.
- **Don't invent design tokens.** Missing colors (paperWarm, nightInk, …) are
  pending from the designer; ask rather than approximate.
- Notification reliability on Mariam's **Oppo (ColorOS)** is the #1 risk:
  prove alarms fire there (screen off, overnight) before polishing UI.
- Transliteration: simple, no academic diacritics (`fa'fu anni`, not `ʿafuwwun`).
- Mariam is a Java/Spring developer; briefly explain non-obvious Flutter choices.

## Local-first: no backend in v1
- Prayer times are computed on-device, duas/athkar ship as bundled JSON, and
  settings live in `SimpleCache`. Location never leaves the device — this is a
  product promise; don't add anything that sends it to a server.
- So the blueprint's HTTP stack (`DioConsumer`, `GenericCrudRepository`,
  pagination mixin, auth interceptor, `SecureCache`) is intentionally absent,
  and pattern 1 (paginated list) doesn't apply. If an external API is added
  later (e.g. Open-Meteo for a rain alert), add Dio + `GenericCrudRepository`
  then.

## Structure & conventions
- No buyer/seller roles: features are flat — `lib/features/<feature>/{data,presentation}`.
- Local repositories still return `Either<Failure, T>`; wrap their work in
  `guard()` (`lib/core/error/guard.dart`).
- `SimpleCache` reads are synchronous (preloaded in `main()`); add new keys to
  `CacheKey` in `lib/core/utils/enums.dart`.
- **Arabic (RTL) is the default locale**, English second. Use directional
  layout (`EdgeInsetsDirectional`, `AlignmentDirectional`, `start`/`end`),
  never left/right, unless something must not mirror.
- Strings live in `assets/translations/{ar,en}.json`. In widgets use
  `context.tr(LocaleKeys.x)` so text rebuilds on locale change.
- Theme: tokens in `AppColors`; UI font Readex Pro (theme default), dua and
  big Arabic titles use `AppTextStyles.dua` / `arabicTitle` (Amiri).
  `AppTheme.night` is provisional until the night palette arrives.
- Prayer times: `features/prayer_times` (`PrayerTimesCalculator`, wraps
  `adhan_dart`; all times are UTC instants). Windows: `features/windows`
  (`WindowCalculator`). Timings the design doesn't specify (iqama delays,
  after-prayer window) live in `WindowConfig` and are provisional.
- Always give adhan_dart a noon-UTC date (its "next day" is +24h, which breaks
  on DST-end days); its polar-circle resolution doesn't work, so the
  calculator throws `CalculationFailure` instead of returning bad times.
- Alerts: `features/alerts`. `AlertPlanner` (pure) → `NotificationService`
  (flutter_local_notifications) via `AlertsRepository`. Alarms are scheduled
  at absolute UTC instants (DST/time-zone safe), 7 days ahead, re-planned on
  app start, resume (throttled 30 min) and language change. Window-alert ids
  are minutes-since-epoch (≥ 1000); ids < 1000 are test alerts.
- **Temporary, remove before release:** the `/debug/alerts` page and its
  Home button; the Alexandria location in `prayerLocationProvider`; all
  windows on in `enabledWindowTypesProvider`.
- App icons are native Android vector drawables (`res/drawable/ic_launcher_foreground.xml`,
  `ic_stat_ijaba.xml` for notifications); legacy PNGs cover API 24–25.

## Commands
- Codegen: `dart run build_runner build` (build_runner 2.15+ ignores
  `--delete-conflicting-outputs`).
- Locale keys, after editing translations:
  `dart run easy_localization:generate -S assets/translations -s en.json -f keys -O lib/generated -o locale_keys.g.dart`
- Add dependencies by editing `pubspec.yaml` then `flutter pub get`: on Windows
  `flutter pub add` goes through `flutter.bat`, which strips `^` from version
  constraints (from PowerShell and Git Bash alike).
