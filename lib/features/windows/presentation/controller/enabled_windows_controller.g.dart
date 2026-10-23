// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enabled_windows_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Which windows alert. All of them until the Windows screen (step 5) lets
/// the user switch each one on or off.

@ProviderFor(enabledWindowTypes)
const enabledWindowTypesProvider = EnabledWindowTypesProvider._();

/// Which windows alert. All of them until the Windows screen (step 5) lets
/// the user switch each one on or off.

final class EnabledWindowTypesProvider
    extends
        $FunctionalProvider<
          Set<DuaWindowType>,
          Set<DuaWindowType>,
          Set<DuaWindowType>
        >
    with $Provider<Set<DuaWindowType>> {
  /// Which windows alert. All of them until the Windows screen (step 5) lets
  /// the user switch each one on or off.
  const EnabledWindowTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enabledWindowTypesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enabledWindowTypesHash();

  @$internal
  @override
  $ProviderElement<Set<DuaWindowType>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Set<DuaWindowType> create(Ref ref) {
    return enabledWindowTypes(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<DuaWindowType> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<DuaWindowType>>(value),
    );
  }
}

String _$enabledWindowTypesHash() =>
    r'ca168bce4af2a662708d7f27bfbd15c0287a5721';
