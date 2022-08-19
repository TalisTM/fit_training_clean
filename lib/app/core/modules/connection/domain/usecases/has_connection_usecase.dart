import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/repositories/connection_repository.dart';

abstract class HasConnectionUsecase {
  Future<Either<FailureConnection, bool>> call();
}

class HasConnectionUsecaseImpl implements HasConnectionUsecase {
  final ConnectionRepository repository;
  HasConnectionUsecaseImpl({required this.repository});
  @override
  Future<Either<FailureConnection, bool>> call() {
    var result = repository.hasConnection();

    return result;
  }
}
