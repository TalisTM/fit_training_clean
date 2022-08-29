import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/data/models/user_model.dart';
import 'package:fit_training_clean/app/modules/login/data/datasources/login_datasource.dart';
import 'package:fit_training_clean/app/modules/login/data/repositories/login_repository_impl.dart';
import 'package:fit_training_clean/app/modules/login/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/login/domain/repositories/login_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginDatasourceMock extends Mock implements LoginDatasource {}

void main() {
  final userMock = UserModel(
    uid: "1234",
    name: "Talis",
    email: "talis@gmail.com",
    photoUrl: "photoUrl",
    amountDone: 0,
    restTimeInSeconds: 30,
    workouts: [],
  );

  late LoginRepository repository;
  late LoginDatasource datasource;

  setUp(() {
    datasource = LoginDatasourceMock();
    repository = LoginRepositoryImpl(datasource: datasource);
  });

  group("LoginEmail", () {
    test("Deve retornar um userModel", () async {
      when(
        () => datasource.loginEmail(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenAnswer((_) async => userMock);

      var result = await repository.loginEmail(email: '', password: '');
      expect(result, Right(userMock));
    });

    test("Deve retornar um ErrorLoginEmail", () async {
      when(
        () => datasource.loginEmail(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenThrow(ErrorLoginEmail());

      var result = await repository.loginEmail(email: '', password: '');

      expect(result.leftMap((l) => l is ErrorLoginEmail), const Left(true));
    });
  });

  group("LoginGoogle", () {
    test("Deve retornar um userModel", () async {
      when(() => datasource.loginGoogle()).thenAnswer((_) async => userMock);

      var result = await repository.loginGoogle();
      expect(result, Right(userMock));
    });

    test("Deve retornar um ErrorLoginGoogle", () async {
      when(() => datasource.loginGoogle()).thenThrow(ErrorLoginGoogle());

      var result = await repository.loginGoogle();

      expect(result.leftMap((l) => l is ErrorLoginGoogle), const Left(true));
    });
  });

  group("RecoverPassword", () {
    test("Deve retornar sucesso", () async {
      when(
        () => datasource.recoverPassword(email: any(named: "email")),
      ).thenAnswer((_) async {});

      var result = await repository.recoverPassword(email: "talis@gmail.com");
      expect(result, const Right(unit));
    });

    test("Deve retornar um ErrorRecoverPassword", () async {
      when(
        () => datasource.recoverPassword(email: any(named: "email")),
      ).thenThrow(ErrorRecoverPassword());

      var result = await repository.recoverPassword(email: "talis@gmail.com");

      expect(result.leftMap((l) => l is ErrorRecoverPassword), const Left(true));
    });
  });
}
