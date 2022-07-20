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

  LoginWithEmailUsecaseImpl(this.repository, this.service);

  @override
  Future<Either<FailureUser, UserEntity>> call(LoginCredentials credential) {
    throw UnimplementedError();
  }

}