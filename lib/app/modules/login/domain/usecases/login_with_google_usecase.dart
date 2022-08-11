import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/modules/login/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/login/domain/repositories/login_repository.dart';

abstract class LoginWithGoogleUsecase {
  Future<Either<FailureLogin, UserEntity>> call(LoginCredentials credential);
}

class LoginWithGoogleUsecaseImpl implements LoginWithGoogleUsecase {
  LoginRepository repository;
  LoginWithGoogleUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureLogin, UserEntity>> call(LoginCredentials credential) async {
    if (!credential.isvalidIdToken || !credential.isvalidAccessToken) {
      return left(ErrorLoginGoogle(message: "Invalid Token"));
    }

    var result = await repository.loginGoogle();
    return result;
  }
}
