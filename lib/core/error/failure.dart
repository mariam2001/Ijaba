/// The only error type allowed to reach the presentation layer.
///
/// [message] is already localized and safe to show to the user.
sealed class Failure implements Exception {
  const Failure(this.message);

  final String message;

  @override
  String toString() => message;
}

final class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

final class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
