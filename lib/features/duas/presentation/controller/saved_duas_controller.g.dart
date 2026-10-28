// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_duas_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ids of the duas the user bookmarked (the Library's "saved" list).

@ProviderFor(SavedDuas)
const savedDuasProvider = SavedDuasProvider._();

/// Ids of the duas the user bookmarked (the Library's "saved" list).
final class SavedDuasProvider
    extends $NotifierProvider<SavedDuas, Set<String>> {
  /// Ids of the duas the user bookmarked (the Library's "saved" list).
  const SavedDuasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedDuasProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedDuasHash();

  @$internal
  @override
  SavedDuas create() => SavedDuas();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$savedDuasHash() => r'4b6dc3925069f804b955c2cbc33348c8afa3dd1f';

/// Ids of the duas the user bookmarked (the Library's "saved" list).

abstract class _$SavedDuas extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
