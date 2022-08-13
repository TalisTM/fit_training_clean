import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/login/domain/errors/errors.dart';

abstract class LoginRepository {
  Future<Either<FailureLogin, UserEntity>> loginEmail({
    required String email,
    required String password,
  });

  Future<Either<FailureLogin, UserEntity>> loginGoogle();
}
