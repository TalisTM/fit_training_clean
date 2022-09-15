import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/data/datasources/auth_datasource.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthDatasource datasource;
  AuthRepositoryImpl({required this.datasource});

  @override
  Future<Either<FailureAuth, UserEntity>> loggedUser() async {
    try {
      var user = await datasource.currentUser();
      return Right(user);
    } catch (e) {
      return Left(ErrorGetLoggedUser(message: "Erro ao obter usuário. \n$e"));
    }
  }

  @override
  Future<Either<FailureAuth, Unit>> logout() async {
    try {
      await datasource.logout();
      return const Right(unit);
    } catch (e) {
      return Left(ErrorLogout(message: "Erro ao desconectar. \n$e"));
    }
  }
}
