// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dua_catalog_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Every dua the app shows: the bundled ones, then the user's own (so on a
/// window's Dua screen theirs come after the sourced duas, and search and
/// the Library find them too). Updates when they add, edit or delete one.

@ProviderFor(duaCatalog)
const duaCatalogProvider = DuaCatalogProvider._();

/// Every dua the app shows: the bundled ones, then the user's own (so on a
/// window's Dua screen theirs come after the sourced duas, and search and
/// the Library find them too). Updates when they add, edit or delete one.

final class DuaCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<DuaCatalog>,
          DuaCatalog,
          FutureOr<DuaCatalog>
        >
    with $FutureModifier<DuaCatalog>, $FutureProvider<DuaCatalog> {
  /// Every dua the app shows: the bundled ones, then the user's own (so on a
  /// window's Dua screen theirs come after the sourced duas, and search and
  /// the Library find them too). Updates when they add, edit or delete one.
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

String _$duaCatalogHash() => r'86c385b9b0b9669aa14e0ea48916f2a4049925fe';
