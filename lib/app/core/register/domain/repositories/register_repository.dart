import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/register/domain/errors/errors.dart';

abstract class RegisterRepository {
  Future<Either<FailureRegister, UserEntity>> registerEmail({
    required String email,
    required String password,
  });
}
