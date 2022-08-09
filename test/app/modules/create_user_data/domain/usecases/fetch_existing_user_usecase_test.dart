import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/repositories/create_user_data_repository.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/usecases/fetch_existing_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CreateUserDataRepositoryMock extends Mock implements CreateUserDataRepository {}

final userEntityMock = UserEntity(
  name: "name",
  email: "email",
  photoUrl: "photoUrl",
  amountDone: 0,
  restTimeInSeconds: 30,
  workouts: [],
);

void main() {
  late CreateUserDataRepository repository;
  late FetchExistingUserUsecase usecase;

  setUp(() {
    repository = CreateUserDataRepositoryMock();
    usecase = FetchExistingUserUsecaseImpl(repository: repository);
  });

  group("Quando chamar FetchExistingUserUsecase,", () {
    test("Deve retornar sucesso", () async {
      when(
        () => repository.fetchExistingUser(userId: any(named: "userId")),
      ).thenAnswer((_) async => Right(userEntityMock));

      var result = await usecase(userId: "34534");

      expect(result, Right(userEntityMock));
    });

    test("Deve retornar um ErrorFetchexistingUser quando o UserId for inválido", () async {
      var result = await usecase(userId: "");

      expect(result.leftMap((l) => l is ErrorFetchExistingUser), const Left(true));
    });

    test("Deve retornar um ErrorFetchexistingUser", () async {
      when(
        () => repository.fetchExistingUser(userId: any(named: "userId")),
      ).thenAnswer((_) async => Left(ErrorFetchExistingUser()));

      var result = await usecase(userId: "23423");

      expect(result.leftMap((l) => l is ErrorFetchExistingUser), const Left(true));
    });
  });
}
