// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clock_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The current time, re-emitted every 20 seconds: enough for minute-level
/// countdowns and for windows to open and close on screen. Tests override it
/// with a fixed time.

@ProviderFor(clock)
const clockProvider = ClockProvider._();

/// The current time, re-emitted every 20 seconds: enough for minute-level
/// countdowns and for windows to open and close on screen. Tests override it
/// with a fixed time.

final class ClockProvider
    extends
        $FunctionalProvider<AsyncValue<DateTime>, DateTime, Stream<DateTime>>
    with $FutureModifier<DateTime>, $StreamProvider<DateTime> {
  /// The current time, re-emitted every 20 seconds: enough for minute-level
  /// countdowns and for windows to open and close on screen. Tests override it
  /// with a fixed time.
  const ClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clockHash();

  @$internal
  @override
  $StreamProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DateTime> create(Ref ref) {
    return clock(ref);
  }
}

String _$clockHash() => r'897a61573d3d469a44a7cfe5496a55b6c5341c75';
