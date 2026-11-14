// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The saved [ThemePreference].

@ProviderFor(ThemeController)
const themeControllerProvider = ThemeControllerProvider._();

/// The saved [ThemePreference].
final class ThemeControllerProvider
    extends $NotifierProvider<ThemeController, ThemePreference> {
  /// The saved [ThemePreference].
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
  Override overrideWithValue(ThemePreference value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemePreference>(value),
    );
  }
}

String _$themeControllerHash() => r'e373ff13d00359d414b890d80a0e88b072d5de22';

/// The saved [ThemePreference].

abstract class _$ThemeController extends $Notifier<ThemePreference> {
  ThemePreference build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ThemePreference, ThemePreference>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemePreference, ThemePreference>,
              ThemePreference,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// The [ThemeMode] the app runs in. "After Maghrib" follows the clock, so
/// the app turns night at Maghrib while it's open; before a location is
/// set (no prayer times yet) it follows the phone.

@ProviderFor(themeMode)
const themeModeProvider = ThemeModeProvider._();

/// The [ThemeMode] the app runs in. "After Maghrib" follows the clock, so
/// the app turns night at Maghrib while it's open; before a location is
/// set (no prayer times yet) it follows the phone.

final class ThemeModeProvider
    extends $FunctionalProvider<ThemeMode, ThemeMode, ThemeMode>
    with $Provider<ThemeMode> {
  /// The [ThemeMode] the app runs in. "After Maghrib" follows the clock, so
  /// the app turns night at Maghrib while it's open; before a location is
  /// set (no prayer times yet) it follows the phone.
  const ThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeHash();

  @$internal
  @override
  $ProviderElement<ThemeMode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeMode create(Ref ref) {
    return themeMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeHash() => r'86f216047764c82137b5e94a8f45f594d1b80c8f';
