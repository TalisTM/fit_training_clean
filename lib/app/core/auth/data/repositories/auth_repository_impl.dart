import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/auth/data/datasources/auth_datasource.dart';
import 'package:fit_training_clean/app/core/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthDatasource datasource;
  AuthRepositoryImpl({required this.datasource});

  @override
  Future<Either<FailureAuth, UserEntity>> loggedUser() async {
    try {
      var user = await datasource.currentUser();
      return Right(user);
    } catch (e) {
      return Left(ErrorGetLoggedUser(message: "Error trying to retrieve logged user"));
    }
  }

  @override
  Future<Either<FailureAuth, Unit>> logout() async {
    try {
      await datasource.logout();
      return const Right(unit);
    } catch (e) {
      return Left(ErrorLogout(message: "Error when logout user"));
    }
  }
}
