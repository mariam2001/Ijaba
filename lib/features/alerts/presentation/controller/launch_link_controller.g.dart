// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_link_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Where to go after the splash when the app was launched by tapping an
/// alert: that window's duas. Null for an ordinary launch.
///
/// The splash screen takes it there rather than anything navigating at
/// once: GoRouter may still be settling its initial route, and the splash's
/// own timer would then send the app Home over it.

@ProviderFor(launchLink)
const launchLinkProvider = LaunchLinkProvider._();

/// Where to go after the splash when the app was launched by tapping an
/// alert: that window's duas. Null for an ordinary launch.
///
/// The splash screen takes it there rather than anything navigating at
/// once: GoRouter may still be settling its initial route, and the splash's
/// own timer would then send the app Home over it.

final class LaunchLinkProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// Where to go after the splash when the app was launched by tapping an
  /// alert: that window's duas. Null for an ordinary launch.
  ///
  /// The splash screen takes it there rather than anything navigating at
  /// once: GoRouter may still be settling its initial route, and the splash's
  /// own timer would then send the app Home over it.
  const LaunchLinkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'launchLinkProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$launchLinkHash();

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return launchLink(ref);
  }
}

String _$launchLinkHash() => r'0aa1a538e99c3e63b3f6556f0749a17477ca9944';

/// An alert tapped while the splash is still showing — on some launches the
/// plugin reports the launching tap this way. The splash follows it.

@ProviderFor(PendingAlertLink)
const pendingAlertLinkProvider = PendingAlertLinkProvider._();

/// An alert tapped while the splash is still showing — on some launches the
/// plugin reports the launching tap this way. The splash follows it.
final class PendingAlertLinkProvider
    extends $NotifierProvider<PendingAlertLink, String?> {
  /// An alert tapped while the splash is still showing — on some launches the
  /// plugin reports the launching tap this way. The splash follows it.
  const PendingAlertLinkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingAlertLinkProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingAlertLinkHash();

  @$internal
  @override
  PendingAlertLink create() => PendingAlertLink();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$pendingAlertLinkHash() => r'38a2f760ae6e38e79b0d356aa771f4a8a5360d11';

/// An alert tapped while the splash is still showing — on some launches the
/// plugin reports the launching tap this way. The splash follows it.

abstract class _$PendingAlertLink extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
