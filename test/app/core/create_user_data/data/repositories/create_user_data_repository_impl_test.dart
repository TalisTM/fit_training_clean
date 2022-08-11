import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/auth/data/models/user_model.dart';
import 'package:fit_training_clean/app/core/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/create_user_data/data/datasources/create_user_data_datasource.dart';
import 'package:fit_training_clean/app/core/create_user_data/data/repositories/create_user_data_repository_impl.dart';
import 'package:fit_training_clean/app/core/create_user_data/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/create_user_data/domain/repositories/create_user_data_repository.dart';
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
  group("Quando o CreateUserDataRepository.createUserData() for chamado,", () {
    test("deve retornar um UserEntity", () async {
      when(
        () => datasouce.createUserData(user: any(named: "user")),
      ).thenAnswer((_) async => userModelMock);

      var result = await repository.createUserData(user: userEntityMock);

      expect(result, Right(userModelMock));
    });

    test("deve retornar um ErrorCreateUserData", () async {
      when(
        () => datasouce.createUserData(user: userModelMock),
      ).thenThrow(Exception());

      var result = await repository.createUserData(user: userModelMock);

      expect(result.leftMap((l) => l is ErrorCreateUserData), const Left(true));
    });
  });
}
