// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enabled_windows_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Which windows alert, as switched on the Windows screen. Windows that are
/// off still show on Home, faded as silent.

@ProviderFor(EnabledWindowTypes)
const enabledWindowTypesProvider = EnabledWindowTypesProvider._();

/// Which windows alert, as switched on the Windows screen. Windows that are
/// off still show on Home, faded as silent.
final class EnabledWindowTypesProvider
    extends $NotifierProvider<EnabledWindowTypes, Set<DuaWindowType>> {
  /// Which windows alert, as switched on the Windows screen. Windows that are
  /// off still show on Home, faded as silent.
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
  EnabledWindowTypes create() => EnabledWindowTypes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<DuaWindowType> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<DuaWindowType>>(value),
    );
  }
}

String _$enabledWindowTypesHash() =>
    r'd9d3ddf4f38852e69ebec5225e929779a3952802';

/// Which windows alert, as switched on the Windows screen. Windows that are
/// off still show on Home, faded as silent.

abstract class _$EnabledWindowTypes extends $Notifier<Set<DuaWindowType>> {
  Set<DuaWindowType> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Set<DuaWindowType>, Set<DuaWindowType>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<DuaWindowType>, Set<DuaWindowType>>,
              Set<DuaWindowType>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
