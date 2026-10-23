import 'package:dartz/dartz.dart' show Left, Right;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:ijaba/core/error/failure.dart';
import 'package:ijaba/core/utils/typedef.dart';
import 'package:ijaba/generated/locale_keys.g.dart';

/// Runs [call] and turns anything it throws into a `Left`, so repositories
/// always resolve to `Either<Failure, T>` and no raw exception reaches the UI.
FutureEither<T> guard<T>(Future<T> Function() call) async {
  try {
    return Right(await call());
  } on Failure catch (failure) {
    return Left(failure);
  } catch (error, stackTrace) {
    debugPrint('Unexpected error: $error\n$stackTrace');
    return Left(UnknownFailure(LocaleKeys.errors_unknown.tr()));
  }
}
