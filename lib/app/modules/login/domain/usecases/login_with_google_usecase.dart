import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/login/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/login/domain/repositories/login_repository.dart';

abstract class LoginWithGoogleUsecase {
  Future<Either<FailureLogin, UserEntity>> call();
}

class LoginWithGoogleUsecaseImpl implements LoginWithGoogleUsecase {
  LoginRepository repository;
  LoginWithGoogleUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureLogin, UserEntity>> call() async {
    var result = await repository.loginGoogle();
    return result;
  }
}
