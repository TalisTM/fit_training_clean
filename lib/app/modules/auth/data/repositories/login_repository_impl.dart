import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/data/datasources/login_datasource.dart';

import 'package:fit_training_clean/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {

  LoginDatasource datasource;
  LoginRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureUser, UserEntity>> loginEmail({required String email, required String password}) async {
    try {
      var user = await datasource.loginEmail(email: email, password: password);
      return Right(user);
    } catch (e) {
      return Left(ErrorLoginEmail(message: "Error login with email"));
    }
  }

  @override
  Future<Either<FailureUser, UserEntity>> loginGoogle({required String idToken, required String accessToken}) async {
    try {
      var user = await datasource.loginGoogle(idToken: idToken, accessToken: accessToken);
      return Right(user);
    } catch (e) {
      return Left(ErrorLoginGoogle(message: "Error login with google"));
    }
  }
  
  @override
  Future<Either<FailureUser, UserEntity>> loggedUser() {
    // TODO: implement loggedUser
    throw UnimplementedError();
  }
  
  @override
  Future<Either<FailureUser, Unit>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
  
}
