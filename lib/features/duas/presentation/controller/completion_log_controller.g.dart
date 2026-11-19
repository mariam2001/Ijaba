// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_log_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The days the user finished each set of duas (a window's, a shelf's), for
/// the completion screen's "ليلتك الرابعة هذا الشهر". Kept on the phone
/// (`CacheKey.completions`): `{key: ["2026-11-19", …]}`, the current and
/// last month only.

@ProviderFor(CompletionLog)
const completionLogProvider = CompletionLogProvider._();

/// The days the user finished each set of duas (a window's, a shelf's), for
/// the completion screen's "ليلتك الرابعة هذا الشهر". Kept on the phone
/// (`CacheKey.completions`): `{key: ["2026-11-19", …]}`, the current and
/// last month only.
final class CompletionLogProvider
    extends $NotifierProvider<CompletionLog, Map<String, List<String>>> {
  /// The days the user finished each set of duas (a window's, a shelf's), for
  /// the completion screen's "ليلتك الرابعة هذا الشهر". Kept on the phone
  /// (`CacheKey.completions`): `{key: ["2026-11-19", …]}`, the current and
  /// last month only.
  const CompletionLogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completionLogProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completionLogHash();

  @$internal
  @override
  CompletionLog create() => CompletionLog();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, List<String>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, List<String>>>(value),
    );
  }
}

String _$completionLogHash() => r'd9058409fd64ca00dfee8163dc8747707f475122';

/// The days the user finished each set of duas (a window's, a shelf's), for
/// the completion screen's "ليلتك الرابعة هذا الشهر". Kept on the phone
/// (`CacheKey.completions`): `{key: ["2026-11-19", …]}`, the current and
/// last month only.

abstract class _$CompletionLog extends $Notifier<Map<String, List<String>>> {
  Map<String, List<String>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<Map<String, List<String>>, Map<String, List<String>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, List<String>>, Map<String, List<String>>>,
              Map<String, List<String>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
