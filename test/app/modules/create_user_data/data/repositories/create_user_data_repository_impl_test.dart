import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/data/models/user_model.dart';
import 'package:fit_training_clean/app/core/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/create_user_data/data/datasources/create_user_data_datasource.dart';
import 'package:fit_training_clean/app/modules/create_user_data/data/repositories/create_user_data_repository_impl.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/repositories/create_user_data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CreateUserDataDatasouceMock extends Mock implements CreateUserDataDatasouce {}

final userModelMock = UserModel(
  uid: "1234",
  name: "name",
  email: "email",
  photoUrl: "photoUrl",
  amountDone: 0,
  restTimeInSeconds: 30,
  workouts: [],
);

final userEntityMock = UserEntity(
  uid: "1234",
  name: "name",
  email: "email",
  photoUrl: "photoUrl",
  amountDone: 0,
  restTimeInSeconds: 30,
  workouts: [],
);

void main() {
  late CreateUserDataDatasouce datasouce;
  late CreateUserDataRepository repository;

  setUp(() {
    datasouce = CreateUserDataDatasouceMock();
    repository = CreateUserDataRepositoryImpl(datasouce: datasouce);

    registerFallbackValue(userModelMock);
  });

  group("Quando o CreateUserDataRepository.checkUserExists() for chamado,", () {
    test("deve retornar um bool", () async {
      when(
        () => datasouce.checkUserExists(userId: any(named: "userId")),
      ).thenAnswer((_) async => true);

      var result = await repository.checkUserExists(userId: "2342");

      expect(result, const Right(true));
    });

    test("deve retornar um ErrorCheckUserExists", () async {
      when(
        () => datasouce.checkUserExists(userId: any(named: "userId")),
      ).thenThrow(Exception());

      var result = await repository.checkUserExists(userId: "234534");

      expect(result.leftMap((l) => l is ErrorCheckUserExists), const Left(true));
    });
  });

  group("Quando o CreateUserDataRepository.saveNewUser() for chamado,", () {
    test("deve retornar sucesso", () async {
      when(
        () => datasouce.saveNewUser(user: any(named: "user")),
      ).thenAnswer((_) async {});

      var result = await repository.saveNewUser(user: userEntityMock);

      expect(result, isA<Right<dynamic, Unit>>());
    });

    test("Deve retornar um ErrorSaveNewUser", () async {
      when(
        () => datasouce.saveNewUser(user: any(named: "user")),
      ).thenThrow(Exception());

      var result = await repository.saveNewUser(user: userModelMock);

      expect(result.leftMap((l) => l is ErrorSaveNewUser), const Left(true));
    });
  });

  group("Quando o CreateUserDataRepository.fetchExistingUser() for chamado,", () {
    test("deve retornar um UserEntity", () async {
      when(
        () => datasouce.fetchExistingUser(userId: any(named: "userId")),
      ).thenAnswer((_) async => userModelMock);

      var result = await repository.fetchExistingUser(userId: "345435");

      expect(result, Right(userModelMock));
    });

    test("deve retornar um ErrorFetchExistingUser", () async {
      when(
        () => datasouce.fetchExistingUser(userId: any(named: "userId")),
      ).thenThrow(Exception());

      var result = await repository.fetchExistingUser(userId: "235234");

      expect(result.leftMap((l) => l is ErrorFetchExistingUser), const Left(true));
    });
  });
}
