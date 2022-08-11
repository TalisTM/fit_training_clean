import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/register/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/register/domain/repositories/register_repository.dart';
import 'package:fit_training_clean/app/core/auth/domain/entities/login_credentials.dart';

abstract class RegisterWithEmailUsecase {
  Future<Either<FailureRegister, UserEntity>> call(LoginCredentials credential);
}

class RegisterWithEmailUsecaseImpl implements RegisterWithEmailUsecase {
  final RegisterRepository repository;
  RegisterWithEmailUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureRegister, UserEntity>> call(LoginCredentials credential) async {
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
