import 'package:dartz/dartz.dart';

import 'package:fit_training_clean/app/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:fit_training_clean/app/modules/auth/domain/services/conectivity_service.dart';

abstract class LoginWithGoogle {
  Future<Either<FailureUser, UserEntity>> call(LoginCredentials credential);
}

class LoginWithGoogleImpl implements LoginWithGoogle {

  LoginRepository repository;
  ConnectivityService service;
  LoginWithGoogleImpl({required this.repository, required this.service});

  @override
  Future<Either<FailureUser, UserEntity>> call(LoginCredentials credential) async {
    var resultConnection = await service.isOnline();
    if(resultConnection.isLeft()){
      return Left(ConnectionError(message: "no connection"));
    }

    if(!credential.isvalidIdToken || !credential.isvalidAccessToken) {
      return left(ErrorLoginGoogle(message: "Invalid Token"));
    }

    var result = await repository.loginGoogle(idToken: credential.idToken!, accessToken: credential.accessToken!);
    return result;
  }

}
