# Ijaba — project context

Duaa reminder app: alerts the user at the best times for duaa. Follows
`~/.claude/flutter-architecture-blueprint.md`, except where this file differs.

## Local-first: no backend in v1
- Prayer times are computed on-device, duas/athkar ship as bundled JSON, and
  settings live in `SimpleCache`. Location never leaves the device — this is a
  product promise; don't add anything that sends it to a server.
- So the blueprint's HTTP stack (`DioConsumer`, `GenericCrudRepository`,
  pagination mixin, auth interceptor, `SecureCache`) is intentionally absent,
  and pattern 1 (paginated list) doesn't apply. If an external API is added
  later (e.g. Open-Meteo for a rain alert), add Dio + `GenericCrudRepository`
  then.
- Planned external pieces: Firebase Crashlytics, optionally Remote Config,
  Google Play Billing for a one-time "support the app" purchase.

## Structure
- No buyer/seller roles: features are flat — `lib/features/<feature>/{data,presentation}`.
- Local repositories still return `Either<Failure, T>`; wrap their work in
  `guard()` (`lib/core/error/guard.dart`).
- `SimpleCache` reads are synchronous (preloaded in `main()`); add new keys to
  `CacheKey` in `lib/core/utils/enums.dart`.
- Strings live in `assets/translations/{en,ar}.json`. In widgets use
  `context.tr(LocaleKeys.x)` so text rebuilds on locale change.

## Commands
- Codegen: `dart run build_runner build` (build_runner 2.15+ ignores
  `--delete-conflicting-outputs`).
- Locale keys, after editing translations:
  `dart run easy_localization:generate -S assets/translations -s en.json -f keys -O lib/generated -o locale_keys.g.dart`
- Add dependencies by editing `pubspec.yaml` then `flutter pub get`: on Windows
  `flutter pub add` goes through `flutter.bat`, which strips `^` from version
  constraints (from PowerShell and Git Bash alike).
