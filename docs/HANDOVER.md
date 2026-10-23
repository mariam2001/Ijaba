# Ijaba (إجابة) — Build Handover

You are picking up a Flutter app whose design is finished. Read this whole file before writing code.
Design source: Figma file "Qareeb — App Screens", page "Ijaba — v2" (owner: Mariam). You can't open Figma from here, so everything you need is below and in `assets/`.

## What the app is
Ijaba alerts Muslims at the times when dua is most likely accepted, plus athkar and prayer reminders.
**The differentiator:** granular control. The user turns each alert ("window") on or off individually, so the app never feels spammy.
Tapping a notification opens straight into the duas for that window.
Goal: a modest-profit side project. Keep v1 small.

## Developer context
- Mariam is a Java/Spring developer who does Flutter on the side. Explain Flutter-specific choices briefly when they're not obvious.
- Her test phone is an **Oppo (ColorOS)**. Aggressive battery management there kills background alarms. This is the #1 technical risk, so prove notifications fire reliably on her phone **before** polishing UI.

## Tech decisions (proposed — confirm with Mariam before locking)
- Flutter, Android first. RTL Arabic is the default; English is the second language.
- Prayer times computed **on device** (e.g. the `adhan` Dart package). Default method: **Egyptian General Authority of Survey**, Asr: **Shafi'i**. No server: the UI promises location never leaves the phone.
- Notifications: `flutter_local_notifications` with **exact alarms** (`SCHEDULE_EXACT_ALARM` / `USE_EXACT_ALARM`), timezone-aware scheduling, rescheduling on boot and timezone change.
- Local storage for settings (shared_preferences or Hive/Isar). No backend in v1.
- Splash: Android 12+ SplashScreen API.

## Brand tokens
| Token | Hex | Use |
|---|---|---|
| paper | `#F6F2E7` | Main background |
| greenPale | `#DCE7DF` | Soft fills, chips |
| greenMid | `#5C8A72` | Secondary |
| green | `#35634F` | Primary, buttons, app-icon background |
| greenDeep | `#1E3A2E` | Strong text/surfaces |
| honey | `#C4873D` | Accent: the star, "open now" states |
| night | `#16221C` | Night-mode background (Dua screen at night) |
| ink | `#22352C` | Body text |

The Figma file also has paperWarm, paperSoft, inkSoft, muted, faint, honeyPale, line, nightCard, nightInk, nightMuted, nightLine. Ask Mariam for those values if you need them, and don't invent them.

**Fonts:** Amiri for Quranic/dua text and big Arabic titles; Readex Pro for all UI text.
**Look:** calm, peaceful, green and cream, natural motifs. Light theme by default; "night mode" switches on automatically after Maghrib.
**Transliteration rule:** simple and readable, with no academic diacritics. Use an apostrophe only when it changes pronunciation.
✓ `Allahumma innaka afuwwun tuhibbul afwa fa'fu anni` ✗ `Allāhumma innaka ʿafuwwun…`

## Assets (`assets/`)
| File | Use |
|---|---|
| `ijaba_logo.svg` | Primary mark (green on light) |
| `ijaba_logo_reversed.svg` | Mark for dark/green backgrounds |
| `ic_launcher_foreground.svg` | Adaptive icon foreground (108dp canvas, mark inside the 66dp safe zone). Android Studio → New → Image Asset; background color `#35634F` |
| `ic_stat_ijaba.svg` | Notification small icon (white silhouette, arch + star only). New → Vector Asset → `ic_stat_ijaba` |
| `play_store_512.svg` | Play Console icon; export to 512×512 PNG |

## Screens (in order)
1. **Splash:** logo + wordmark "إجابة / IJABA", footer verse: وَإِذَا سَأَلَكَ عِبَادِي عَنِّي فَإِنِّي قَرِيبٌ
2. **Language:** Arabic (Arabic text + meaning) or English (Arabic + transliteration + meaning). The Arabic dua text never changes; only the translation does. Changeable later.
3. **Welcome:** "For dua there are times when the doors open." Explains the windows and that the user picks which ones reach them. Button: هيّا نبدأ. 3-step progress dots.
4. **Location:** use current location, or pick a city manually. Shows the calculation method. Copy: times are calculated on your device and never sent to a server.
5. **Permissions (3 steps):** (1) notifications, (2) exact alarms (opens the system setting directly), (3) **Oppo autostart + battery**, the step everyone forgets. Primary button "افتح إعدادات Oppo". Skip link warns alerts may not arrive. Detect the manufacturer and show OEM-specific guidance.
6. **Home:** header (wordmark + Hijri date). Hero card for the currently open window: "open now" badge, name, time range, countdown remaining, progress bar, CTA "ادعُ الآن" → Dua screen. List "Today's windows" with an Edit link.
7. **Windows (Alert control):** the core screen. Toggle per window with a subtitle, plus a counter chip "4 / 6 alerts on". Windows:
   - Last third of the night: alert 15 min before, soft chime
   - Between adhan and iqama: Fajr and Maghrib only
   - After the obligatory prayers: silent by default
   - The hour of response on Friday: last hour before Maghrib
   - Morning and evening adhkar: one alert each
   - When it rains: needs location (consider leaving this out of v1, since it needs weather data)
8. **Dua (night):** context header (window + time + "2 of 7"). Arabic dua (Amiri), transliteration (EN mode), meaning, source. Tasbih counter ("2 of 3", tap to count). Previous/Next.
9. **Library:** search + categories: morning adhkar, evening adhkar, duas of the last third, authentic (ma'thur) duas, saved.
10. **Settings:** location, calculation method, Asr madhab, manual time adjustment (±min), alert tone, vibration, night mode (auto after Maghrib), language, about.

Bottom tab bar on main screens: Home · Duas · Windows · Settings.

## ⚠️ Content accuracy
Every dua needs a verified source (hadith reference) before release. The designs mark sources as "[verify attribution before release]". **Do not invent or guess hadith references.** Use placeholders and leave verification to Mariam.

## Suggested build order
1. Project setup, theme tokens, fonts, RTL + l10n scaffolding, app icon.
2. Prayer-time engine + window calculation (unit-tested; the last third = from 2/3 of Maghrib→Fajr to Fajr).
3. **Notification scheduling, then test on the Oppo**, including overnight with the screen off. Don't move on until this works.
4. Onboarding flow (Language → Welcome → Location → Permissions).
5. Home + Windows screens.
6. Dua screen + Library + notification deep links.
7. Settings, then polish.
