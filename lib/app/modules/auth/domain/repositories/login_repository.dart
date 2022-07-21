import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';

abstract class LoginRepository {
  Future<Either<FailureUser, UserEntity>> loginEmail({required String email, required String password});
}