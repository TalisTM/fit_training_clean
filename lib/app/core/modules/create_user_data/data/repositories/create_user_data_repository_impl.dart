import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/data/models/user_model.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/data/datasources/create_user_data_datasource.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/domain/repositories/create_user_data_repository.dart';

class CreateUserDataRepositoryImpl implements CreateUserDataRepository {
  final CreateUserDataDatasouce datasouce;
  CreateUserDataRepositoryImpl({required this.datasouce});

  @override
  Future<Either<FailureCreateUserData, UserEntity>> createUserData({
    required UserEntity user,
  }) async {
    try {
      UserModel userModel = UserModel(
        uid: user.uid,
        name: user.name,
        email: user.email,
        photoUrl: user.photoUrl,
        amountDone: user.amountDone,
        restTimeInSeconds: user.restTimeInSeconds,
        workouts: user.workouts,
      );

      var resultUser = await datasouce.createUserData(user: userModel);

      return Right(resultUser);
    } catch (e) {
      return Left(ErrorCreateUserData(message: "Erro ao salvar dados do usuário. \n$e"));
    }
  }
}
