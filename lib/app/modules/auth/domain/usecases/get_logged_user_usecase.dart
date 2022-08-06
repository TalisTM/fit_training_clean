import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';

abstract class GetLoggedUserUsecase {
  Future<Either<FailureUser, UserEntity>> call();
}

class GetLoggedUserUsecaseImpl implements GetLoggedUserUsecase {

  final LoginRepository repository;
  GetLoggedUserUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureUser, UserEntity>> call() async {
    return await repository.loggedUser();
  }
  
}