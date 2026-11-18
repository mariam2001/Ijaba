// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dua_catalog.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The bundled duas, loaded once, on first use. Screens read
/// `duaCatalogProvider`, which adds the user's own.

@ProviderFor(bundledDuaCatalog)
const bundledDuaCatalogProvider = BundledDuaCatalogProvider._();

/// The bundled duas, loaded once, on first use. Screens read
/// `duaCatalogProvider`, which adds the user's own.

final class BundledDuaCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<DuaCatalog>,
          DuaCatalog,
          FutureOr<DuaCatalog>
        >
    with $FutureModifier<DuaCatalog>, $FutureProvider<DuaCatalog> {
  /// The bundled duas, loaded once, on first use. Screens read
  /// `duaCatalogProvider`, which adds the user's own.
  const BundledDuaCatalogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bundledDuaCatalogProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bundledDuaCatalogHash();

  @$internal
  @override
  $FutureProviderElement<DuaCatalog> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<DuaCatalog> create(Ref ref) {
    return bundledDuaCatalog(ref);
  }
}

String _$bundledDuaCatalogHash() => r'85299b157703b0af6cd4d95d71454acc50c64f6c';
