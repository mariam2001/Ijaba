// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dua_catalog.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Loaded once, on first use.

@ProviderFor(duaCatalog)
const duaCatalogProvider = DuaCatalogProvider._();

/// Loaded once, on first use.

final class DuaCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<DuaCatalog>,
          DuaCatalog,
          FutureOr<DuaCatalog>
        >
    with $FutureModifier<DuaCatalog>, $FutureProvider<DuaCatalog> {
  /// Loaded once, on first use.
  const DuaCatalogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'duaCatalogProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$duaCatalogHash();

  @$internal
  @override
  $FutureProviderElement<DuaCatalog> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<DuaCatalog> create(Ref ref) {
    return duaCatalog(ref);
  }
}

String _$duaCatalogHash() => r'462a48eb8edb57a2b0126c6323578cf7b689b63b';
