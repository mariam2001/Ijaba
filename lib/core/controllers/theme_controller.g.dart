// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Light by default; the design's "night mode" (auto after Maghrib) will
/// drive this once prayer times exist. It deliberately ignores the OS
/// dark-mode setting.

@ProviderFor(ThemeController)
const themeControllerProvider = ThemeControllerProvider._();

/// Light by default; the design's "night mode" (auto after Maghrib) will
/// drive this once prayer times exist. It deliberately ignores the OS
/// dark-mode setting.
final class ThemeControllerProvider
    extends $NotifierProvider<ThemeController, ThemeMode> {
  /// Light by default; the design's "night mode" (auto after Maghrib) will
  /// drive this once prayer times exist. It deliberately ignores the OS
  /// dark-mode setting.
  const ThemeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeControllerHash();

  @$internal
  @override
  ThemeController create() => ThemeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeControllerHash() => r'99da1296ec0fb924364eef55ece3ab94a965240f';

/// Light by default; the design's "night mode" (auto after Maghrib) will
/// drive this once prayer times exist. It deliberately ignores the OS
/// dark-mode setting.

abstract class _$ThemeController extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
