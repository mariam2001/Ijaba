// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_duas_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The duas the user wrote, in the order they were added. Saved on the
/// phone only (`CacheKey.customDuas`), like every other setting.

@ProviderFor(CustomDuas)
const customDuasProvider = CustomDuasProvider._();

/// The duas the user wrote, in the order they were added. Saved on the
/// phone only (`CacheKey.customDuas`), like every other setting.
final class CustomDuasProvider
    extends $NotifierProvider<CustomDuas, List<CustomDua>> {
  /// The duas the user wrote, in the order they were added. Saved on the
  /// phone only (`CacheKey.customDuas`), like every other setting.
  const CustomDuasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customDuasProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customDuasHash();

  @$internal
  @override
  CustomDuas create() => CustomDuas();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CustomDua> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CustomDua>>(value),
    );
  }
}

String _$customDuasHash() => r'6227151b305ecdd45ff7f7dfb402032605c83606';

/// The duas the user wrote, in the order they were added. Saved on the
/// phone only (`CacheKey.customDuas`), like every other setting.

abstract class _$CustomDuas extends $Notifier<List<CustomDua>> {
  List<CustomDua> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<CustomDua>, List<CustomDua>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<CustomDua>, List<CustomDua>>,
              List<CustomDua>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
