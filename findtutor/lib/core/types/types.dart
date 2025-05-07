import 'package:dartz/dartz.dart';
import '/core/models/generic_error.dart';

class Failure {
  final String message;
  final StackTrace? stackTrace;

  const Failure(this.message, this.stackTrace);
}

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherGeneric<T> = Future<Either<GenericError, T>>;
typedef FutureEitherVoid = FutureEither<void>;
