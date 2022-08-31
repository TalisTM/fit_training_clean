import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/login/data/datasources/login_datasource.dart';
import 'package:fit_training_clean/app/modules/login/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginDatasource datasource;
  LoginRepositoryImpl({required this.datasource});

  @override
  Future<Either<FailureLogin, UserEntity>> loginEmail({
    required String email,
    required String password,
  }) async {
    try {
      var user = await datasource.loginEmail(email: email, password: password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return Left(ErrorLoginEmail(message: "Já existe uma conta vinculada a este e-mail."));
      }
      if (e.code == "user-not-found") {
        return Left(ErrorLoginEmail(message: "Usuário não encontrado."));
      }
      if (e.code == "wrong-password") {
        return Left(ErrorLoginEmail(message: "Senha inválida ou este usuário não possui uma senha."));
      }
      return Left(ErrorLoginEmail(message: "Erro ao fazer login"));
    } catch (e) {
      return Left(ErrorLoginEmail(message: "Erro ao fazer login"));
    }
  }

  @override
  Future<Either<FailureLogin, UserEntity>> loginGoogle() async {
    try {
      var user = await datasource.loginGoogle();
      return Right(user);
    } catch (e) {
      return Left(ErrorLoginGoogle(message: "Erro ao tentar autenticar com google."));
    }
  }

  @override
  Future<Either<FailureLogin, Unit>> recoverPassword({required String email}) async {
    try {
      await datasource.recoverPassword(email: email);
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return Left(ErrorRecoverPassword(
          message:
              "Não há registro de usuário correspondente a este e-mail. O usuário pode ter sido excluído.",
        ));
      }

      return Left(ErrorRecoverPassword(message: "Erro ao tentar recuperar senha."));
    } catch (e) {
      return Left(ErrorRecoverPassword(message: "Erro ao tentar recuperar senha."));
    }
  }
}
