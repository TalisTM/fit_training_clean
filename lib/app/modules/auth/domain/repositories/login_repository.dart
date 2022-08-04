import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/google_authentication_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';

abstract class LoginRepository {
  Future<Either<FailureUser, UserEntity>> registerEmail({
    required String email,
    required String password,
  });

  Future<Either<FailureUser, UserEntity>> loginEmail({
    required String email,
    required String password,
  });

  Future<Either<FailureUser, GoogleAuthenticationEntity>> getGoogleAuthentication();

  Future<Either<FailureUser, UserEntity>> loginGoogle({
    required String idToken,
    required String accessToken,
  });

  Future<Either<FailureUser, UserEntity>> loggedUser();

  Future<Either<FailureUser, Unit>> logout();
}
