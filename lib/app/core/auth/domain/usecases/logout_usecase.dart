import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/auth/domain/repositories/auth_repository.dart';

abstract class LogoutUsecase {
  Future<Either<FailureAuth, Unit>> call();
}

class LogoutUsecaseImpl implements LogoutUsecase {
  final AuthRepository repository;
  LogoutUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureAuth, Unit>> call() async {
    return await repository.logout();
  }
}
