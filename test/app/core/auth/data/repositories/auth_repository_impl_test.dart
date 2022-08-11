import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/auth/data/datasources/auth_datasource.dart';
import 'package:fit_training_clean/app/core/auth/data/models/user_model.dart';
import 'package:fit_training_clean/app/core/auth/data/repositories/auth_repository_impl.dart';
import 'package:fit_training_clean/app/core/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthDatasourceMock extends Mock implements AuthDatasource {}

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

  late AuthRepository repository;
  late AuthDatasource datasource;

  setUp(() {
    datasource = AuthDatasourceMock();
    repository = AuthRepositoryImpl(datasource: datasource);
  });

  group("LoggedUser", () {
    test("Deve retornar um userModel", () async {
      when(() => datasource.currentUser()).thenAnswer((_) async => userMock);

      var result = await repository.loggedUser();

      expect(result, Right(userMock));
    });

    test("Deve retornar um ErrorGetLoggedUser", () async {
      when(() => datasource.currentUser()).thenThrow(Left(ErrorGetLoggedUser()));

      var result = await repository.loggedUser();

      expect(result.leftMap((l) => l is ErrorGetLoggedUser), const Left(true));
    });
  });

  group("Logout", () {
    test("Deve fazer o logout", () async {
      when(() => datasource.logout()).thenAnswer((_) async {});

      var result = await repository.logout();

      expect(result, isA<Right<dynamic, Unit>>());
    });

    test("Deve retornar um ErrorLogout", () async {
      when(() => datasource.logout()).thenThrow(ErrorLogout());

      var result = await repository.logout();

      expect(result.leftMap((l) => l is ErrorLogout), const Left(true));
    });
  });
}
