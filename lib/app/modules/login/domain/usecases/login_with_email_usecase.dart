import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/login/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/login/domain/repositories/login_repository.dart';

abstract class LoginWithEmailUsecase {
  Future<Either<FailureLogin, UserEntity>> call(LoginCredentials credential);
}

class LoginWithEmailUsecaseImpl implements LoginWithEmailUsecase {
  final LoginRepository repository;
  LoginWithEmailUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureLogin, UserEntity>> call(LoginCredentials credential) async {
    if (!credential.isValidEmail) {
      return Left(ErrorLoginEmail(message: "Invalid email"));
    } else if (!credential.isValidPassword) {
      return Left(ErrorLoginEmail(message: "Invalid password"));
    }

    var result =
        await repository.loginEmail(email: credential.email!, password: credential.password!);

    return result;
  }
}
