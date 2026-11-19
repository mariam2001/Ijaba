// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_moments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Which reminder Home's card opens on: the next one each time the app
/// starts (a keep-alive provider is built once per run).

@ProviderFor(reminderStart)
const reminderStartProvider = ReminderStartProvider._();

/// Which reminder Home's card opens on: the next one each time the app
/// starts (a keep-alive provider is built once per run).

final class ReminderStartProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Which reminder Home's card opens on: the next one each time the app
  /// starts (a keep-alive provider is built once per run).
  const ReminderStartProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderStartProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderStartHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return reminderStart(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$reminderStartHash() => r'735e189f3322475e36a65e21c60c2464879913a3';

/// The welcome card at the end of onboarding (Figma "Warm moments"): shown
/// on Home the first time after onboarding, until tapped away, and not on
/// later runs.

@ProviderFor(WelcomeCard)
const welcomeCardProvider = WelcomeCardProvider._();

/// The welcome card at the end of onboarding (Figma "Warm moments"): shown
/// on Home the first time after onboarding, until tapped away, and not on
/// later runs.
final class WelcomeCardProvider extends $NotifierProvider<WelcomeCard, bool> {
  /// The welcome card at the end of onboarding (Figma "Warm moments"): shown
  /// on Home the first time after onboarding, until tapped away, and not on
  /// later runs.
  const WelcomeCardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'welcomeCardProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$welcomeCardHash();

  @$internal
  @override
  WelcomeCard create() => WelcomeCard();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$welcomeCardHash() => r'bd89ba4c25107da0c13b6a4ce8fde3c287500fb4';

/// The welcome card at the end of onboarding (Figma "Warm moments"): shown
/// on Home the first time after onboarding, until tapped away, and not on
/// later runs.

abstract class _$WelcomeCard extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
