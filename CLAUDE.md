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
  `context.tr(LocaleKeys.x)` so text rebuilds on locale change. Plurals use
  real CLDR rules (`ignorePluralRules: false` in `App`): Arabic needs
  one/two/few/many/other ("٥ دقائق" but "١٥ دقيقة").
- Theme: tokens in `AppColors` (the handover's 8, plus 7 sampled from the
  Figma exports — paperSoft/paperWarm names are inferred, confirm them);
  sizes in `AppTextStyles` were measured from the exports. Readex Pro for UI
  text (every style names its font — buttons don't inherit the theme's);
  Amiri for dua text and Arabic titles only (`screenTitleFor(locale)` switches
  Latin titles to Readex). `AppTheme.night` is provisional until the night
  palette arrives. ScreenUtil design size is the Figma frame, 390 × 844.
  Icons are Lucide (`lucide_icons_flutter`, the `…300` variants = 1.5 stroke),
  matching the design's glyphs.
- Onboarding: `features/onboarding` (Splash → Language → Welcome → Location
  → Permissions; router redirects Home until `OnboardingController` is done).
  Location: `features/location` — GPS (coarse) labelled with the nearest city
  from the bundled `assets/data/cities.json` (Natural Earth, public domain,
  built by `tool/generate_cities.py`), so no geocoding API sees the location.
- Placeholders awaiting assets/designs: `IjabaMark` and `BranchOrnament` are
  drawn in code from the PNG exports — swap in the Figma SVGs when exported;
  the city picker and the "pending" permission-step style have no design yet.
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
  are minutes-since-epoch (≥ 1000); ids < 1000 are test alerts. Heads-ups
  come early by `AlertPlanner.leadTimes` (last third 15 min; adhan→iqama
  5 min, from the Home design), and Home's rows show the same lead times.
- Main tabs: `StatefulShellRoute` in `routes.dart` with `MainShell` +
  `AppTabBar` (Home · Duas · Windows · Settings); Duas and Settings are
  `ComingSoonView` placeholders until steps 6–7.
- Windows tab (alert control): `WindowsPage` with one `AlertToggle` per
  switch — morning and evening adhkar share one; the design's "when it
  rains" is left out of v1 (it would need a weather service to see the
  location). Switches only control alerts: they're saved by
  `EnabledWindowTypes` (`CacheKey.enabledWindows`; default all on except
  after-prayer), and Home still lists switched-off windows, faded as
  silent. A change re-plans the alarms through `_AlertScheduler`;
  `AlertsController` queues a forced run asked for mid-run, so the last
  change always lands. `AppSwitch` is drawn to the design (44 × 26) and,
  like the design, doesn't mirror in Arabic.
- Home: `features/home`. `todayWindowsProvider` (windows open now or starting
  in the next 24 h, from yesterday/today/tomorrow's prayer days) is recomputed
  on each `clockProvider` tick (20 s). The hero card features the open window
  with the highest `featurePriority`, else the next one ("up next" state is
  ours — the design only shows "open now"). The Hijri date is Umm al-Qura by
  civil date (package `hijri`; month names come from l10n). "Make dua now"
  opens the Dua screen for the featured window; search goes to the Duas tab
  until the Library exists.
- Dua screen: `features/duas`, route `/dua/<DuaWindowType name>` (outside
  the tab shell; notifications will deep-link there). One dua at a time with
  Previous/Next, a tasbih counter (per dua, kept when going back) and a
  bookmark (`SavedDuas`, `CacheKey.savedDuas`). Built in the **day palette**
  — the design is a night screen, but the night palette isn't decided yet.
  Content is `assets/data/duas.json` (`DuaCatalog`): `arabic`,
  `transliteration`, `meaning`/`source` by language code, `verified`,
  `repeat`, `windows` (none = any window; a window with no tagged duas gets
  them all). Only the design's one dua is in it so far — Mariam supplies the
  rest. Unverified sources show the "[verify attribution before release]"
  flag; never add a source or set `verified` yourself.
- **Temporary, remove before release:** the `/debug/alerts` page and its
  button on the Settings placeholder.
- App icons are native Android vector drawables (`res/drawable/ic_launcher_foreground.xml`,
  `ic_stat_ijaba.xml` for notifications); legacy PNGs cover API 24–25.

## Testing
- Widget tests pump `App(translations: TestTranslations())` with the fakes in
  `test/helpers/fakes.dart` (asset loading is unreliable in widget tests).
  Never use `SynchronousFuture` in an easy_localization `AssetLoader` — it
  combines loaders with `Future.wait`, which mishandles it (keys show raw).
- `test/features/onboarding/onboarding_screens_test.dart` lays out every
  onboarding screen on small/design/large phones and fails on overflow;
  `test/features/home/home_page_test.dart`,
  `test/features/windows/windows_page_test.dart` and
  `test/features/duas/dua_page_test.dart` do the same for Home, Windows and
  the Dua screen in both languages (the Dua tests use `designDuaCatalog()`:
  the real dua among dummies, as "2 of 7"). easy_localization remembers `setLocale` across tests in a file,
  so tests set the language they need every time.
- Design fidelity: `flutter test tool/design_check/design_check_test.dart`
  renders the screens at 390 × 844 to `build/design_check/` for comparison
  with the Figma PNG exports (the Figma MCP Starter plan allows only 20
  reads a month, so exports are the working path). Home renders the
  design's moment (Friday 03:12, `designTodayWindows()` in the fakes).

## Commands
- Codegen: `dart run build_runner build` (build_runner 2.15+ ignores
  `--delete-conflicting-outputs`).
- Locale keys, after editing translations:
  `dart run easy_localization:generate -S assets/translations -s en.json -f keys -O lib/generated -o locale_keys.g.dart`
- Add dependencies by editing `pubspec.yaml` then `flutter pub get`: on Windows
  `flutter pub add` goes through `flutter.bat`, which strips `^` from version
  constraints (from PowerShell and Git Bash alike).
