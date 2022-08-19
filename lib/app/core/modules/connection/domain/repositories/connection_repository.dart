import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/errors/errors.dart';

abstract class ConnectionRepository {
  Future<Either<FailureConnection, bool>> hasConnection();
}
