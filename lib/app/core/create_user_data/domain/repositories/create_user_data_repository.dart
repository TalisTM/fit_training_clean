import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/create_user_data/domain/errors/errors.dart';

abstract class CreateUserDataRepository {
  Future<Either<FailureCreateUser, UserEntity>> createUserData({required UserEntity user});
}
