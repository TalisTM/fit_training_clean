import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';
import 'package:fit_training_clean/app/core/utils/utils.dart';
import 'package:fit_training_clean/app/modules/login/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/login/domain/repositories/login_repository.dart';

abstract class LoginWithGoogleUsecase {
  Future<Either<FailureLogin, UserEntity>> call();
}

class LoginWithGoogleUsecaseImpl implements LoginWithGoogleUsecase {
  LoginRepository repository;
  final HasConnectionUsecase hasConnectionUsecase;
  LoginWithGoogleUsecaseImpl({required this.repository, required this.hasConnectionUsecase});

  @override
  Future<Either<FailureLogin, UserEntity>> call() async {
    String? hasConnection = await Utils.connection.hasConnection(hasConnectionUsecase);
    if (hasConnection != null) {
      return Left(ErrorRecoverPassword(message: hasConnection));
    }

    var result = await repository.loginGoogle();
    return result;
  }
}
