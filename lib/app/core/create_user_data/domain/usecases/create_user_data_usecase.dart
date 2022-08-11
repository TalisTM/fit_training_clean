import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/create_user_data/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/create_user_data/domain/repositories/create_user_data_repository.dart';

abstract class CreateUserDataUsecase {
  Future<Either<FailureCreateUserData, UserEntity>> call({required UserEntity user});
}

class CreateUserDataUsecaseImpl implements CreateUserDataUsecase {
  final CreateUserDataRepository repository;
  CreateUserDataUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureCreateUserData, UserEntity>> call({required UserEntity user}) async {
    var result = await repository.createUserData(user: user);

    return result;
  }
}
