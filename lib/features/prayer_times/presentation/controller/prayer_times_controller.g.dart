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

/// Calculation settings; defaults until the Settings screen persists them.

@ProviderFor(prayerSettings)
const prayerSettingsProvider = PrayerSettingsProvider._();

/// Calculation settings; defaults until the Settings screen persists them.

final class PrayerSettingsProvider
    extends $FunctionalProvider<PrayerSettings, PrayerSettings, PrayerSettings>
    with $Provider<PrayerSettings> {
  /// Calculation settings; defaults until the Settings screen persists them.
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

String _$prayerSettingsHash() => r'648ee116956926fc84d23e88bec7714d2c8d4f27';
