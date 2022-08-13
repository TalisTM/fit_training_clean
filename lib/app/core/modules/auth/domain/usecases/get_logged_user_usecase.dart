import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/repositories/auth_repository.dart';

abstract class GetLoggedUserUsecase {
  Future<Either<FailureAuth, UserEntity>> call();
}

class GetLoggedUserUsecaseImpl implements GetLoggedUserUsecase {
  final AuthRepository repository;
  GetLoggedUserUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureAuth, UserEntity>> call() async {
    return await repository.loggedUser();
  }
}
