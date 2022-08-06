import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/core/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:fit_training_clean/app/modules/auth/domain/services/conectivity_service.dart';

abstract class RegisterWithEmailUsecase {
  Future<Either<FailureUser, UserEntity>> call(LoginCredentials credential);
}

class RegisterWithEmailUsecaseImpl implements RegisterWithEmailUsecase {
  final LoginRepository repository;
  final ConnectivityService service;
  RegisterWithEmailUsecaseImpl({required this.repository, required this.service});

  @override
  Future<Either<FailureUser, UserEntity>> call(LoginCredentials credential) async {
    var resultConnection = await service.isOnline();
    if (resultConnection.isLeft()) {
      return Left(ConnectionError(message: "no connection"));
    }

    if (!credential.isValidEmail) {
      return Left(ErrorRegisterEmail(message: "invalid email"));
    } else if (!credential.isValidPassword) {
      return Left(ErrorRegisterEmail(message: "invalid password"));
    }

    var result = await repository.registerEmail(
      email: credential.email!,
      password: credential.password!,
    );

    return result;
  }
}
