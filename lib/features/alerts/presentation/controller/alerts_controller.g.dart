// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Keeps the coming days' window alerts scheduled. The app calls
/// [reschedule] on start, on every return to the foreground, and when the
/// language changes.

@ProviderFor(AlertsController)
const alertsControllerProvider = AlertsControllerProvider._();

/// Keeps the coming days' window alerts scheduled. The app calls
/// [reschedule] on start, on every return to the foreground, and when the
/// language changes.
final class AlertsControllerProvider
    extends $NotifierProvider<AlertsController, GlobalStates<ScheduleResult>> {
  /// Keeps the coming days' window alerts scheduled. The app calls
  /// [reschedule] on start, on every return to the foreground, and when the
  /// language changes.
  const AlertsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alertsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alertsControllerHash();

  @$internal
  @override
  AlertsController create() => AlertsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GlobalStates<ScheduleResult> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GlobalStates<ScheduleResult>>(value),
    );
  }
}

String _$alertsControllerHash() => r'6a42c9ec6f43daed1cdcf634987dcde28e95713a';

/// Keeps the coming days' window alerts scheduled. The app calls
/// [reschedule] on start, on every return to the foreground, and when the
/// language changes.

abstract class _$AlertsController
    extends $Notifier<GlobalStates<ScheduleResult>> {
  GlobalStates<ScheduleResult> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<GlobalStates<ScheduleResult>, GlobalStates<ScheduleResult>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                GlobalStates<ScheduleResult>,
                GlobalStates<ScheduleResult>
              >,
              GlobalStates<ScheduleResult>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Whether the two permissions alerts depend on are granted.

@ProviderFor(alertPermissions)
const alertPermissionsProvider = AlertPermissionsProvider._();

/// Whether the two permissions alerts depend on are granted.

final class AlertPermissionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<({bool exactAlarms, bool notifications})>,
          ({bool exactAlarms, bool notifications}),
          FutureOr<({bool exactAlarms, bool notifications})>
        >
    with
        $FutureModifier<({bool exactAlarms, bool notifications})>,
        $FutureProvider<({bool exactAlarms, bool notifications})> {
  /// Whether the two permissions alerts depend on are granted.
  const AlertPermissionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alertPermissionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alertPermissionsHash();

  @$internal
  @override
  $FutureProviderElement<({bool exactAlarms, bool notifications})>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<({bool exactAlarms, bool notifications})> create(Ref ref) {
    return alertPermissions(ref);
  }
}

String _$alertPermissionsHash() => r'463608076a1c87a61f0ee6bc186b164f20e09261';
