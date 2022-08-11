import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/repositories/create_user_data_repository.dart';

abstract class SaveNewUserUsecase {
  Future<Either<FailureCreateUser, Unit>> call({required UserEntity user});
}

class SaveNewUserUsecaseImpl implements SaveNewUserUsecase {
  final CreateUserDataRepository repository;
  SaveNewUserUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureCreateUser, Unit>> call({required UserEntity user}) async {
    var result = await repository.saveNewUser(user: user);

    return result;
  }
}
