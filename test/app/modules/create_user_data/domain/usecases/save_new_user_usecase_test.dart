import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/repositories/create_user_data_repository.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/usecases/save_new_user_usecase.dart';
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
  late SaveNewUserUsecase usecase;

  setUp(() {
    repository = CreateUserDataRepositoryMock();
    usecase = SaveNewUserUsecaseImpl(repository: repository);

    registerFallbackValue(userEntityMock);
  });

  group("Quando o SaveNewUserUsecase for chamado,", () {
    test("Deve retornar sucesso", () async {
      when(
        () => repository.saveNewUser(user: any(named: "user")),
      ).thenAnswer((_) async => const Right(unit));

      var result = await usecase(userEntityMock);

      expect(result, isA<Right<dynamic, Unit>>());
    });

    test("Deve retornar um ErrorSaveNewUser", () async {
      when(
        () => repository.saveNewUser(user: any(named: "user")),
      ).thenAnswer((_) async => Left(ErrorSaveNewUser()));

      var result = await usecase(userEntityMock);

      expect(result.leftMap((l) => l is ErrorSaveNewUser), const Left(true));
    });
  });
}
