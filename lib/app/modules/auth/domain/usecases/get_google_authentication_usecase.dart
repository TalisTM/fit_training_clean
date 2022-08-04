import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/google_authentication_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';

abstract class GetGoogleAuthenticationUsecase {
  Future<Either<FailureUser, GoogleAuthenticationEntity>> call();
}

class GetGoogleAuthenticationUsecaseImpl implements GetGoogleAuthenticationUsecase {
  final LoginRepository repository;
  GetGoogleAuthenticationUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureUser, GoogleAuthenticationEntity>> call() async {
    var result = await repository.getGoogleAuthentication();
    return result;
  }
}
