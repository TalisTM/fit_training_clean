import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/data/datasources/login_datasource.dart';

import 'package:fit_training_clean/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {

  LoginDatasource datasource;
  LoginRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureUser, UserEntity>> loginEmail({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureUser, UserEntity>> loginGoogle({required String idToken, required String accessToken}) {
    throw UnimplementedError();
  }
  
}
