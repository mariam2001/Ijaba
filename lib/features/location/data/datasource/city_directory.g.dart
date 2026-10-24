// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_directory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Loaded once, on first use.

@ProviderFor(cityDirectory)
const cityDirectoryProvider = CityDirectoryProvider._();

/// Loaded once, on first use.

final class CityDirectoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<CityDirectory>,
          CityDirectory,
          FutureOr<CityDirectory>
        >
    with $FutureModifier<CityDirectory>, $FutureProvider<CityDirectory> {
  /// Loaded once, on first use.
  const CityDirectoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cityDirectoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cityDirectoryHash();

  @$internal
  @override
  $FutureProviderElement<CityDirectory> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CityDirectory> create(Ref ref) {
    return cityDirectory(ref);
  }
}

String _$cityDirectoryHash() => r'c2f903d111c3ca0ab0bae54d5c165e90fac52bbb';
