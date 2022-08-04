import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/data/datasources/login_datasource.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/google_authentication_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginDatasource datasource;
  LoginRepositoryImpl({required this.datasource});

  @override
  Future<Either<FailureUser, UserEntity>> registerEmail({
    required String email,
    required String password,
  }) async {
    try {
      var user = await datasource.registerEmail(email: email, password: password);
      return Right(user);
    } catch (e) {
      return Left(ErrorRegisterEmail(message: "Error register with email"));
    }
  }

  @override
  Future<Either<FailureUser, UserEntity>> loginEmail({
    required String email,
    required String password,
  }) async {
    try {
      var user = await datasource.loginEmail(email: email, password: password);
      return Right(user);
    } catch (e) {
      return Left(ErrorLoginEmail(message: "Error login with email"));
    }
  }

  @override
  Future<Either<FailureUser, GoogleAuthenticationEntity>> getGoogleAuthentication() async {
    try {
      var googleAuthentication = await datasource.getGoogleAuthentication();
      return Right(googleAuthentication);
    } catch (e) {
      return Left(ErrorGetGoogleAuthentication(message: "Error google authentication"));
    }
  }

  @override
  Future<Either<FailureUser, UserEntity>> loginGoogle(
      {required String idToken, required String accessToken}) async {
    try {
      var user = await datasource.loginGoogle(idToken: idToken, accessToken: accessToken);
      return Right(user);
    } catch (e) {
      return Left(ErrorLoginGoogle(message: "Error login with google"));
    }
  }

  @override
  Future<Either<FailureUser, UserEntity>> loggedUser() async {
    try {
      var user = await datasource.currentUser();
      return Right(user);
    } catch (e) {
      return Left(ErrorGetLoggedUser(message: "Error trying to retrieve logged user"));
    }
  }

  @override
  Future<Either<FailureUser, Unit>> logout() async {
    try {
      await datasource.logout();
      return const Right(unit);
    } catch (e) {
      return Left(ErrorLogout(message: "Error when logout user"));
    }
  }
}
