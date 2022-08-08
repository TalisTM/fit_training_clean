import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/repositories/create_user_data_repository.dart';

abstract class CheckUserExistsUsecase {
  Future<Either<FailureCreateUser, bool>> call({required String userId});
}

class CheckUserExistsUsecaseImpl implements CheckUserExistsUsecase {
  final CreateUserDataRepository repository;
  CheckUserExistsUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureCreateUser, bool>> call({required String userId}) async {
    if (userId.isEmpty) {
      return Left(ErrorCheckUserExists(message: "Invalid UserID"));
    }

    var result = await repository.checkUserExists(userId: userId);

    return result;
  }
}
