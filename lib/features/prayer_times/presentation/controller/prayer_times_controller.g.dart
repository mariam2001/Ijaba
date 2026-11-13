// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_times_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Where prayer times are calculated; null until onboarding saves a location.

@ProviderFor(prayerLocation)
const prayerLocationProvider = PrayerLocationProvider._();

/// Where prayer times are calculated; null until onboarding saves a location.

final class PrayerLocationProvider
    extends $FunctionalProvider<GeoPoint?, GeoPoint?, GeoPoint?>
    with $Provider<GeoPoint?> {
  /// Where prayer times are calculated; null until onboarding saves a location.
  const PrayerLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prayerLocationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prayerLocationHash();

  @$internal
  @override
  $ProviderElement<GeoPoint?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GeoPoint? create(Ref ref) {
    return prayerLocation(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeoPoint? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeoPoint?>(value),
    );
  }
}

String _$prayerLocationHash() => r'56c9ee4d1e1a6b9dc9fad1288e332b13fb546fe6';

/// Calculation settings, as chosen in Settings (stored on the device).

@ProviderFor(prayerSettings)
const prayerSettingsProvider = PrayerSettingsProvider._();

/// Calculation settings, as chosen in Settings (stored on the device).

final class PrayerSettingsProvider
    extends $FunctionalProvider<PrayerSettings, PrayerSettings, PrayerSettings>
    with $Provider<PrayerSettings> {
  /// Calculation settings, as chosen in Settings (stored on the device).
  const PrayerSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prayerSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prayerSettingsHash();

  @$internal
  @override
  $ProviderElement<PrayerSettings> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PrayerSettings create(Ref ref) {
    return prayerSettings(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrayerSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrayerSettings>(value),
    );
  }
}

String _$prayerSettingsHash() => r'3bcbcec7d94666a0bbef1da7fe57283a1e498e0e';

@ProviderFor(PrayerSettingsController)
const prayerSettingsControllerProvider = PrayerSettingsControllerProvider._();

final class PrayerSettingsControllerProvider
    extends $NotifierProvider<PrayerSettingsController, PrayerSettings> {
  const PrayerSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prayerSettingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prayerSettingsControllerHash();

  @$internal
  @override
  PrayerSettingsController create() => PrayerSettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrayerSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrayerSettings>(value),
    );
  }
}

String _$prayerSettingsControllerHash() =>
    r'4da5e7359d9117dc3b71e5a7b4743deab48402bf';

abstract class _$PrayerSettingsController extends $Notifier<PrayerSettings> {
  PrayerSettings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PrayerSettings, PrayerSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PrayerSettings, PrayerSettings>,
              PrayerSettings,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
