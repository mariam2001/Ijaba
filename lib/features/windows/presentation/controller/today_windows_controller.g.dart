// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_windows_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The windows for Home, recomputed on every clock tick (cheap: three days
/// of prayer times) and whenever the location or settings change. Fails with
/// `CalculationFailure` where prayer times can't be computed.

@ProviderFor(todayWindows)
const todayWindowsProvider = TodayWindowsProvider._();

/// The windows for Home, recomputed on every clock tick (cheap: three days
/// of prayer times) and whenever the location or settings change. Fails with
/// `CalculationFailure` where prayer times can't be computed.

final class TodayWindowsProvider
    extends
        $FunctionalProvider<
          AsyncValue<TodayWindows>,
          TodayWindows,
          FutureOr<TodayWindows>
        >
    with $FutureModifier<TodayWindows>, $FutureProvider<TodayWindows> {
  /// The windows for Home, recomputed on every clock tick (cheap: three days
  /// of prayer times) and whenever the location or settings change. Fails with
  /// `CalculationFailure` where prayer times can't be computed.
  const TodayWindowsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayWindowsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayWindowsHash();

  @$internal
  @override
  $FutureProviderElement<TodayWindows> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TodayWindows> create(Ref ref) {
    return todayWindows(ref);
  }
}

String _$todayWindowsHash() => r'694aa074a4099f3cdb5bedd57a3c5627947bda55';
