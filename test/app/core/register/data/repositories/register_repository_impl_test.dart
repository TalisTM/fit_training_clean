import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/auth/data/models/user_model.dart';
import 'package:fit_training_clean/app/core/register/data/datasources/register_datasource.dart';
import 'package:fit_training_clean/app/core/register/data/repositories/register_repository_impl.dart';
import 'package:fit_training_clean/app/core/register/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/register/domain/repositories/register_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class RegisterDatasourceMock extends Mock implements RegisterDatasource {}

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

  late RegisterRepository repository;
  late RegisterDatasource datasource;

  setUp(() {
    datasource = RegisterDatasourceMock();
    repository = RegisterRepositoryImpl(datasource: datasource);
  });

  group("RegisterEmail", () {
    test("Deve retornar um UserModel", () async {
      when(
        () => datasource.registerEmail(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenAnswer((_) async => userMock);

      var result = await repository.registerEmail(
        email: "",
        password: "",
      );

      expect(result, Right(userMock));
    });

    test("Deve retornar um ErrorRegisterEmail", () async {
      when(
        () => datasource.registerEmail(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenThrow(ErrorRegisterEmail());

      var result = await repository.registerEmail(
        email: "",
        password: "",
      );

      expect(result.leftMap((l) => l is ErrorRegisterEmail), const Left(true));
    });
  });
}
