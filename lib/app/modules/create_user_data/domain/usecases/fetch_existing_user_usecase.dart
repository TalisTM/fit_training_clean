import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/repositories/create_user_data_repository.dart';

abstract class FetchExistingUserUsecase {
  Future<Either<FailureCreateUser, UserEntity>> call({required String userId});
}

class FetchExistingUserUsecaseImpl implements FetchExistingUserUsecase {
  final CreateUserDataRepository repository;
  FetchExistingUserUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureCreateUser, UserEntity>> call({required String userId}) async {
    if (userId.isEmpty) {
      return Left(ErrorFetchExistingUser(message: "Invalid userId"));
    }

    var result = await repository.fetchExistingUser(userId: userId);

    return result;
  }
}
