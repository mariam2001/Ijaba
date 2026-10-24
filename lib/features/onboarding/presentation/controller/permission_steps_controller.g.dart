// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission_steps_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PermissionStepsController)
const permissionStepsControllerProvider = PermissionStepsControllerProvider._();

final class PermissionStepsControllerProvider
    extends $AsyncNotifierProvider<PermissionStepsController, PermissionSteps> {
  const PermissionStepsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'permissionStepsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$permissionStepsControllerHash();

  @$internal
  @override
  PermissionStepsController create() => PermissionStepsController();
}

String _$permissionStepsControllerHash() =>
    r'14d5a8fac068a28ee11fab4f760eb385b3a63695';

abstract class _$PermissionStepsController
    extends $AsyncNotifier<PermissionSteps> {
  FutureOr<PermissionSteps> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<PermissionSteps>, PermissionSteps>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PermissionSteps>, PermissionSteps>,
              AsyncValue<PermissionSteps>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
