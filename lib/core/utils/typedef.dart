import 'package:dartz/dartz.dart' show Either;
import 'package:ijaba/core/error/failure.dart';

typedef Json = Map<String, Object?>;

typedef FutureEither<T> = Future<Either<Failure, T>>;
