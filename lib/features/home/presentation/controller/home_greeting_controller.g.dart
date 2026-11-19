// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_greeting_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The greeting now; recomputed on each clock tick.

@ProviderFor(homeGreeting)
const homeGreetingProvider = HomeGreetingProvider._();

/// The greeting now; recomputed on each clock tick.

final class HomeGreetingProvider
    extends $FunctionalProvider<HomeGreeting, HomeGreeting, HomeGreeting>
    with $Provider<HomeGreeting> {
  /// The greeting now; recomputed on each clock tick.
  const HomeGreetingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeGreetingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeGreetingHash();

  @$internal
  @override
  $ProviderElement<HomeGreeting> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeGreeting create(Ref ref) {
    return homeGreeting(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeGreeting value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeGreeting>(value),
    );
  }
}

String _$homeGreetingHash() => r'878da0918f59e8a22113c7a03a3008b9f3bcd566';
