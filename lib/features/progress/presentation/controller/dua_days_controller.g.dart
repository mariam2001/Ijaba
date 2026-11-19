// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dua_days_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The days the user finished at least one set of duas (a window's or a
/// shelf's — the completion screen showed), for "أسبوعك مع الدعاء" on Home
/// and "أيامك مع إجابة" in Settings. Only the dates, only on the phone
/// (`CacheKey.duaDays`); never shared, never notified. Days are only ever
/// added, so the count never goes down.

@ProviderFor(DuaDays)
const duaDaysProvider = DuaDaysProvider._();

/// The days the user finished at least one set of duas (a window's or a
/// shelf's — the completion screen showed), for "أسبوعك مع الدعاء" on Home
/// and "أيامك مع إجابة" in Settings. Only the dates, only on the phone
/// (`CacheKey.duaDays`); never shared, never notified. Days are only ever
/// added, so the count never goes down.
final class DuaDaysProvider extends $NotifierProvider<DuaDays, Set<DateTime>> {
  /// The days the user finished at least one set of duas (a window's or a
  /// shelf's — the completion screen showed), for "أسبوعك مع الدعاء" on Home
  /// and "أيامك مع إجابة" in Settings. Only the dates, only on the phone
  /// (`CacheKey.duaDays`); never shared, never notified. Days are only ever
  /// added, so the count never goes down.
  const DuaDaysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'duaDaysProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$duaDaysHash();

  @$internal
  @override
  DuaDays create() => DuaDays();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<DateTime> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<DateTime>>(value),
    );
  }
}

String _$duaDaysHash() => r'15a55564d9100f1d666ba1278cb920b3f90356ce';

/// The days the user finished at least one set of duas (a window's or a
/// shelf's — the completion screen showed), for "أسبوعك مع الدعاء" on Home
/// and "أيامك مع إجابة" in Settings. Only the dates, only on the phone
/// (`CacheKey.duaDays`); never shared, never notified. Days are only ever
/// added, so the count never goes down.

abstract class _$DuaDays extends $Notifier<Set<DateTime>> {
  Set<DateTime> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Set<DateTime>, Set<DateTime>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<DateTime>, Set<DateTime>>,
              Set<DateTime>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
