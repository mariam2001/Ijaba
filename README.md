# Ijaba
Your duaa buddy that alerts you of the best duaa times.

## Development

Requires Flutter 3.41+ (stable channel).

```bash
flutter pub get
flutter run
```

After changing anything annotated with `@riverpod`, `@freezed` or `@JsonSerializable`:

```bash
dart run build_runner build
```

After editing `assets/translations/*.json`:

```bash
dart run easy_localization:generate -S assets/translations -s en.json -f keys -O lib/generated -o locale_keys.g.dart
```
