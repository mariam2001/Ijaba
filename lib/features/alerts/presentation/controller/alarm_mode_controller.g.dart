// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_mode_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Which Android alarm type the alerts use — an experiment knob for the
/// ColorOS reliability test:
/// - `exactAllowWhileIdle`: standard exact reminder alarm (the default).
/// - `alarmClock`: treated like a user alarm; strongest against battery
///   savers, but Android shows an alarm icon in the status bar.

@ProviderFor(AlarmModeController)
const alarmModeControllerProvider = AlarmModeControllerProvider._();

/// Which Android alarm type the alerts use — an experiment knob for the
/// ColorOS reliability test:
/// - `exactAllowWhileIdle`: standard exact reminder alarm (the default).
/// - `alarmClock`: treated like a user alarm; strongest against battery
///   savers, but Android shows an alarm icon in the status bar.
final class AlarmModeControllerProvider
    extends $NotifierProvider<AlarmModeController, AndroidScheduleMode> {
  /// Which Android alarm type the alerts use — an experiment knob for the
  /// ColorOS reliability test:
  /// - `exactAllowWhileIdle`: standard exact reminder alarm (the default).
  /// - `alarmClock`: treated like a user alarm; strongest against battery
  ///   savers, but Android shows an alarm icon in the status bar.
  const AlarmModeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alarmModeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alarmModeControllerHash();

  @$internal
  @override
  AlarmModeController create() => AlarmModeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AndroidScheduleMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AndroidScheduleMode>(value),
    );
  }
}

String _$alarmModeControllerHash() =>
    r'656e52960381a31f216fac9c3c4575746d3a41fa';

/// Which Android alarm type the alerts use — an experiment knob for the
/// ColorOS reliability test:
/// - `exactAllowWhileIdle`: standard exact reminder alarm (the default).
/// - `alarmClock`: treated like a user alarm; strongest against battery
///   savers, but Android shows an alarm icon in the status bar.

abstract class _$AlarmModeController extends $Notifier<AndroidScheduleMode> {
  AndroidScheduleMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AndroidScheduleMode, AndroidScheduleMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AndroidScheduleMode, AndroidScheduleMode>,
              AndroidScheduleMode,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
