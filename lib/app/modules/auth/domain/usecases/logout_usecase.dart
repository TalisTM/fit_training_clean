import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';

abstract class LogoutUsecase {
  Future<Either<FailureUser, Unit>> call();
}

class LogoutUsecaseImpl implements LogoutUsecase {

  final LoginRepository repository;
  LogoutUsecaseImpl(this.repository);


  @override
  Future<Either<FailureUser, Unit>> call() async {
    return await repository.logout();
  }

} 