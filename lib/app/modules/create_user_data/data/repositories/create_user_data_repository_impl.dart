import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/data/models/user_model.dart';
import 'package:fit_training_clean/app/core/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/create_user_data/data/datasources/create_user_data_datasource.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/repositories/create_user_data_repository.dart';

class CreateUserDataRepositoryImpl implements CreateUserDataRepository {
  final CreateUserDataDatasouce datasouce;
  CreateUserDataRepositoryImpl({required this.datasouce});

  @override
  Future<Either<FailureCreateUser, bool>> checkUserExists({required String userId}) async {
    try {
      var result = await datasouce.checkUserExists(userId: userId);
      return Right(result);
    } catch (e) {
      return Left(ErrorCheckUserExists(message: "Error check user exists"));
    }
  }

  @override
  Future<Either<FailureCreateUser, Unit>> saveNewUser({required UserEntity user}) async {
    try {
      UserModel userModel = UserModel(
        name: user.name,
        email: user.email,
        photoUrl: user.photoUrl,
        amountDone: user.amountDone,
        restTimeInSeconds: user.restTimeInSeconds,
        workouts: user.workouts,
      );

      await datasouce.saveNewUser(user: userModel);

      return const Right(unit);
    } catch (e) {
      return Left(ErrorSaveNewUser(message: "Error save new user"));
    }
  }

  @override
  Future<Either<FailureCreateUser, UserEntity>> fetchExistingUser({required String userId}) async {
    try {
      var user = await datasouce.fetchExistingUser(userId: userId);

      return Right(user);
    } catch (e) {
      return Left(ErrorFetchExistingUser(message: "Erro fetch existing user"));
    }
  }
}
