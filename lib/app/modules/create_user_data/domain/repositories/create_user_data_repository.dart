import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/errors/errors.dart';

abstract class CreateUserDataRepository {
  Future<Either<FailureCreateUser, bool>> checkUserExists({required String userId});
}
