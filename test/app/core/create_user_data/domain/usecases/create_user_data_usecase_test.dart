import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/domain/repositories/create_user_data_repository.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/domain/usecases/create_user_data_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CreateUserDataRepositoryMock extends Mock implements CreateUserDataRepository {}

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
  late CreateUserDataRepository repository;
  late CreateUserDataUsecase usecase;

  setUp(() {
    repository = CreateUserDataRepositoryMock();
    usecase = CreateUserDataUsecaseImpl(repository: repository);
  });

  group("Quando chamar CreateUserDataUsecase,", () {
    test("Deve retornar um UserEntity", () async {
      registerFallbackValue(userEntityMock);
      when(
        () => repository.createUserData(user: any(named: "user")),
      ).thenAnswer((_) async => Right(userEntityMock));

      var result = await usecase(user: userEntityMock);

      expect(result, Right(userEntityMock));
    });

    test("Deve retornar um ErrorCreateUserData", () async {
      when(
        () => repository.createUserData(user: any(named: "user")),
      ).thenAnswer((_) async => Left(ErrorCreateUserData()));

      var result = await usecase(user: userEntityMock);

      expect(result.leftMap((l) => l is ErrorCreateUserData), const Left(true));
    });
  });
}
