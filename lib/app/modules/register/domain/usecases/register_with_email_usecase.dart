import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';
import 'package:fit_training_clean/app/core/utils/utils.dart';
import 'package:fit_training_clean/app/modules/register/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/register/domain/repositories/register_repository.dart';

abstract class RegisterWithEmailUsecase {
  Future<Either<FailureRegister, UserEntity>> call(LoginCredentials credential);
}

class RegisterWithEmailUsecaseImpl implements RegisterWithEmailUsecase {
  final RegisterRepository repository;
  final HasConnectionUsecase hasConnectionUsecase;
  RegisterWithEmailUsecaseImpl({required this.repository, required this.hasConnectionUsecase});

  @override
  Future<Either<FailureRegister, UserEntity>> call(LoginCredentials credential) async {
    String? hasConnection = await Utils.connection.hasConnection(hasConnectionUsecase);
    if (hasConnection != null) {
      return Left(ErrorRegisterEmail(message: hasConnection));
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
