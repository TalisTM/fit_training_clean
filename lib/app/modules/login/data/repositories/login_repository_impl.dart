import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/login/data/datasources/login_datasource.dart';
import 'package:fit_training_clean/app/modules/login/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginDatasource datasource;
  LoginRepositoryImpl({required this.datasource});

  @override
  Future<Either<FailureLogin, UserEntity>> loginEmail({
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
  Future<Either<FailureLogin, UserEntity>> loginGoogle() async {
    try {
      var user = await datasource.loginGoogle();
      return Right(user);
    } catch (e) {
      return Left(ErrorLoginGoogle(message: "Error login with google"));
    }
  }
}
