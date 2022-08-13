import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/domain/errors/errors.dart';

abstract class CreateUserDataRepository {
  Future<Either<FailureCreateUserData, UserEntity>> createUserData({required UserEntity user});
}
