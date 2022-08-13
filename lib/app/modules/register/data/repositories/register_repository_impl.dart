import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/register/data/datasources/register_datasource.dart';
import 'package:fit_training_clean/app/modules/register/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/register/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  RegisterDatasource datasource;
  RegisterRepositoryImpl({required this.datasource});

  @override
  Future<Either<FailureRegister, UserEntity>> registerEmail({
    required String email,
    required String password,
  }) async {
    try {
      var user = await datasource.registerEmail(email: email, password: password);
      return Right(user);
    } catch (e) {
      return Left(ErrorRegisterEmail(message: "Error register with email"));
    }
  }
}
