import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_states.freezed.dart';

/// State of a mutation (POST / PUT / PATCH / DELETE) controller.
@freezed
sealed class GlobalStates<T> with _$GlobalStates<T> {
  const GlobalStates._();

  const factory GlobalStates.initial() = GlobalStatesInitial<T>;
  const factory GlobalStates.loading() = GlobalStatesLoading<T>;
  const factory GlobalStates.success(T data) = GlobalStatesSuccess<T>;
  const factory GlobalStates.fail(String message) = GlobalStatesFail<T>;

  bool get isLoading => this is GlobalStatesLoading<T>;
}
