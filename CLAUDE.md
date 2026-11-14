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
  matching the design's glyphs — no Material icons. The app's own glyphs
  (one per window, dua hands, saved, …) are the handover's SVGs in
  `assets/icons/` via `AppIcon`/`AppIconView` (flutter_svg, tinted with a
  colour filter); `window_art.dart` maps each window to its icon and its
  hero illustration (`assets/illustrations/`). Readex styles fall back to
  Amiri for glyphs Readex lacks (ﷺ).
- Onboarding: `features/onboarding` (Splash → Language → Welcome → Location
  → Permissions; router redirects Home until `OnboardingController` is done).
  Location: `features/location` — GPS (coarse) labelled with the nearest city
  from the bundled `assets/data/cities.json` (Natural Earth, public domain,
  built by `tool/generate_cities.py`), so no geocoding API sees the location.
- Placeholders awaiting assets/designs: `IjabaMark` and `BranchOrnament` are
  drawn in code from the PNG exports — swap in the Figma SVGs when exported
  (the handover's small `ic_ijaba_mark` is in `AppIcon`, meant for About and
  empty states, not the splash logo); the city picker and the "pending" permission-step style have no design yet.
- Prayer times: `features/prayer_times` (`PrayerTimesCalculator`, wraps
  `adhan_dart`; all times are UTC instants). Windows: `features/windows`
  (`WindowCalculator`). Timings with no fixed Islamic value (iqama delay per
  prayer, prayer length, after-prayer window) are `WindowConfig`, adjustable
  in Settings (`WindowConfigController`, `CacheKey.windowConfig`; ranges
  there) and read through `windowConfigProvider` by Home and the alerts.
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
  `AppTabBar` (Home · Duas · Windows · Settings).
- Windows tab (alert control): `WindowsPage` with one `AlertToggle` per
  switch — morning and evening adhkar share one; the design's "when it
  rains" is left out of v1 (it would need a weather service to see the
  location). Switches only control alerts: they're saved by
  `EnabledWindowTypes` (`CacheKey.enabledWindows`; default all on except
  after-prayer), and Home still lists switched-off windows, faded as
  silent. A change re-plans the alarms through `_AlertScheduler`;
  `AlertsController` queues a forced run asked for mid-run, so the last
  change always lands. `AppSwitch` is drawn to the design (44 × 26) and,
  like the design, doesn't mirror in Arabic. Each row starts with the
  window's icon on a small tile (honey for adhkar, green otherwise; faded
  when off).
- Home: `features/home`. `todayWindowsProvider` (windows open now or starting
  in the next 24 h, from yesterday/today/tomorrow's prayer days) is recomputed
  on each `clockProvider` tick (20 s). The hero card features the open window
  with the highest `featurePriority`, else the next one ("up next" state is
  ours — the design only shows "open now"; it gets the "التالية" badge and
  an empty progress bar). The window's illustration sits at the end of the
  text (left in Arabic), centred on the block from the badge down to the
  countdown — Mariam's call over the handover's corner placement, which
  looked stuck to the top. It's drawn at its full 160 × 120, reaching into
  the card's end padding (`OverflowBox`) so the title keeps two lines, and
  fades out at its foot (`ShaderMask`). The progress bar and button run full
  width below.
  The card colour and Amiri title stay as in the design. Rows show the window's
  icon in place of the status dot, tinted by status. The Hijri date is Umm al-Qura by
  civil date (package `hijri`; month names come from l10n). "Make dua now"
  opens the Dua screen for the featured window; search opens the Library
  (Duas tab) with its search field focused (`AppRoutes.librarySearch()`, a
  fresh `?search=` value each time so a repeat tap focuses again).
- Dua screen: `features/duas`, outside the tab shell; opened alone (a
  tapped alert), Back goes Home. It steps through a `DuaSelection`: a
  window's duas (`/dua/<DuaWindowType name>` — Home, alerts), a Library
  shelf (`/library/<LibraryCategory name>`) or one search hit
  (`/library/dua/<id>`); the list is fixed for the visit. One dua at a time with
  Previous/Next, a tasbih counter (per dua, kept when going back) and a
  bookmark (`SavedDuas`, `CacheKey.savedDuas`). Built in the **day palette**
  — the design is a night screen, but the night palette isn't decided yet.
  Content is `assets/data/duas.json` (`DuaCatalog`): `arabic`,
  `transliteration`, `meaning`/`source` by language code, `url` (where to
  check it), `verified`, `repeat`, `windows` (none = any window; a window
  with no tagged duas gets them all; file order is display order).
- Library (Duas tab): `LibraryPage` — search (`DuaCatalog.search`, via
  `searchable()` in `core/utils/search_text.dart`, shared with the city
  search: harakat- and hamza-insensitive, over Arabic, transliteration and
  meanings) and five shelves (`LibraryCategory`): morning, evening and last
  third follow `windows`; "ma'thur" is the duas flagged `general: true`;
  saved is the bookmarks (an empty shelf can't be opened). The tiles hold
  the shelf's icon (the export has plain tiles; the handover's icons came
  later); search results have no design
  and borrow the card style. Arabic only in the export; English mirrors it.
- The base dua list (51, researched with Mariam's go-ahead) and how it was
  made — sources, grading bar, exclusions — is in `docs/DUA_SOURCES.md`.
  When adding duas: cut the Arabic from the source (sunnah.com primary page,
  official Hisn al-Muslim text, Quran API) rather than retyping it; only
  well-authenticated narrations; cite the reference you checked, with its
  link. `verified` stays `false` until Mariam checks it — a test enforces
  this. Arabic-mode meanings exist only where written (Arabic mode hides an
  empty one); long duas (> 120 chars) render smaller.
- Alert taps: each alert's payload is its window names (`AlertPayload`); a
  tap opens the Dua screen of the one Home would feature. While the app
  runs, `_AlertTapHandler` (app.dart) pushes it over the current screen. A
  tap that launched the app is followed by the **splash** when it moves on
  (`launchLinkProvider`, or `PendingAlertLink` if the plugin reported it as
  a live tap during the splash) — navigating any earlier loses to GoRouter's
  initial route and the splash timer. Verified on the emulator, warm and
  cold. The developer test alert opens the last third, to check this too.
- Settings tab: `SettingsPage` — rows (`SettingsSection`/`SettingsRow`) open
  bottom sheets (`showOptionSheet`/`showAppSheet` in core/components; no
  design for them yet; they open on the root navigator so they cover the
  tab bar). Prayer settings (method — all adhan_dart methods but "other";
  Asr madhab; per-prayer adhan adjustment ±30 min, whose sheet shows today's
  calculated time → adjusted time) are saved by
  `PrayerSettingsController` (`CacheKey.prayerSettings`);
  `prayerSettingsProvider` reads it. "Iqama & prayer" (`IqamaSheet`) edits
  `WindowConfig`; both sheets use `StepperRow`. Signed minutes are wrapped in
  LTR isolate marks (`signedMinutes`) so "+٢" keeps its sign first in
  Arabic. Location re-uses onboarding's GPS
  detection and city picker. Location and settings changes re-plan the
  alerts. Alert tone and vibration open Android's settings for the alert
  channel (a channel's sound and vibration can't be changed by the app once
  created, and we have no sound files); night mode is shown inert until the
  night palette is built (handover `ijaba-assets/ASSETS.md` has the tokens;
  it will follow the phone by default, changeable here).
- **Temporary, remove before release:** the `/debug/alerts` page; its link
  at the bottom of Settings shows in debug builds only.
- The phone's navigation bar is hidden while the app is open; a swipe up
  shows it for a moment (`MainActivity`, re-applied after Flutter's
  `onPostResume` and on regaining focus). Done natively because
  `SystemChrome` can't hide only that bar with swipe-to-reveal. Checked on
  the Oppo (3-button navigation).
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
  design's moment (Friday 03:12, `designTodayWindows()` in the fakes). The
  Settings sheets (no design) are rendered too, to check by eye.

## Commands
- Codegen: `dart run build_runner build` (build_runner 2.15+ ignores
  `--delete-conflicting-outputs`).
- Locale keys, after editing translations:
  `dart run easy_localization:generate -S assets/translations -s en.json -f keys -O lib/generated -o locale_keys.g.dart`
- Add dependencies by editing `pubspec.yaml` then `flutter pub get`: on Windows
  `flutter pub add` goes through `flutter.bat`, which strips `^` from version
  constraints (from PowerShell and Git Bash alike).
