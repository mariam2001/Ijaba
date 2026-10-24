// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The location prayer times are calculated for; null until onboarding sets
/// it. Stored on the device only.

@ProviderFor(LocationController)
const locationControllerProvider = LocationControllerProvider._();

/// The location prayer times are calculated for; null until onboarding sets
/// it. Stored on the device only.
final class LocationControllerProvider
    extends $NotifierProvider<LocationController, SavedLocation?> {
  /// The location prayer times are calculated for; null until onboarding sets
  /// it. Stored on the device only.
  const LocationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationControllerHash();

  @$internal
  @override
  LocationController create() => LocationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SavedLocation? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SavedLocation?>(value),
    );
  }
}

String _$locationControllerHash() =>
    r'eedbc5f1d813dbf1b6a9874a247fb572174bcdb5';

/// The location prayer times are calculated for; null until onboarding sets
/// it. Stored on the device only.

abstract class _$LocationController extends $Notifier<SavedLocation?> {
  SavedLocation? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SavedLocation?, SavedLocation?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SavedLocation?, SavedLocation?>,
              SavedLocation?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
