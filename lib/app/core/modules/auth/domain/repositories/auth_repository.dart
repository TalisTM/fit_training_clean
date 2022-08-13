import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/errors/errors.dart';

abstract class AuthRepository {
  Future<Either<FailureAuth, UserEntity>> loggedUser();

  Future<Either<FailureAuth, Unit>> logout();
}
