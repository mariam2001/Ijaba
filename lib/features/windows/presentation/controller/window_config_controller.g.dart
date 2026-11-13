// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'window_config_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The iqama and prayer timings windows are built from, as set in Settings.

@ProviderFor(windowConfig)
const windowConfigProvider = WindowConfigProvider._();

/// The iqama and prayer timings windows are built from, as set in Settings.

final class WindowConfigProvider
    extends $FunctionalProvider<WindowConfig, WindowConfig, WindowConfig>
    with $Provider<WindowConfig> {
  /// The iqama and prayer timings windows are built from, as set in Settings.
  const WindowConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'windowConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$windowConfigHash();

  @$internal
  @override
  $ProviderElement<WindowConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WindowConfig create(Ref ref) {
    return windowConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WindowConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WindowConfig>(value),
    );
  }
}

String _$windowConfigHash() => r'f66b8b9282b905a22f1bd13c0bcbfaa27b1a30f6';

@ProviderFor(WindowConfigController)
const windowConfigControllerProvider = WindowConfigControllerProvider._();

final class WindowConfigControllerProvider
    extends $NotifierProvider<WindowConfigController, WindowConfig> {
  const WindowConfigControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'windowConfigControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$windowConfigControllerHash();

  @$internal
  @override
  WindowConfigController create() => WindowConfigController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WindowConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WindowConfig>(value),
    );
  }
}

String _$windowConfigControllerHash() =>
    r'f1c771edec4e92caac9e287ea6241ff024acd4ad';

abstract class _$WindowConfigController extends $Notifier<WindowConfig> {
  WindowConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WindowConfig, WindowConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WindowConfig, WindowConfig>,
              WindowConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
