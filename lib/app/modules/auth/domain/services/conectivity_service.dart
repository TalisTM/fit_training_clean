import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';

abstract class ConnectivityService {
  Future<Either<FailureUser, Unit>> isOnline();
}