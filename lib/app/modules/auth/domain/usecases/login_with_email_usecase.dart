import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:fit_training_clean/app/modules/auth/domain/services/conectivity_service.dart';

abstract class LoginWithEmailUsecase {
  Future<Either<FailureUser, UserEntity>> call(LoginCredentials credential);
}

class LoginWithEmailUsecaseImpl implements LoginWithEmailUsecase {
  
  final LoginRepository repository;
  final ConnectivityService service;

  LoginWithEmailUsecaseImpl({required this.repository, required  this.service});

  @override
  Future<Either<FailureUser, UserEntity>> call(LoginCredentials credential) async {
    var resultConnection = await service.isOnline();
    if(resultConnection.isLeft()) {
      return Left(ConnectionError(message: "no connection"));
    }

    if(!credential.isValidEmail) {
      return Left(ErrorLoginEmail(message: "Invalid email"));
    } else if(!credential.isValidPassword) {
      return Left(ErrorLoginEmail(message: "Invalid password"));
    }
    
    var result = await repository.loginEmail(email: credential.email!, password: credential.password!);

    return result;
  }

}