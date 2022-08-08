import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/repositories/create_user_data_repository.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/usecases/check_user_exists_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CreateUserDataRepositoryMock extends Mock implements CreateUserDataRepository {}

void main() {
  late CreateUserDataRepository repository;
  late CheckUserExistsUsecase usecase;

  setUp(() {
    repository = CreateUserDataRepositoryMock();
    usecase = CheckUserExistsUsecaseImpl(repository: repository);
  });

  group("Quando chamar o CheckUserExistsUsecase,", () {
    test("Deve retornar um bool", () async {
      when(
        () => repository.checkUserExists(userId: any(named: "userId")),
      ).thenAnswer((_) async => const Right(true));

      var result = await usecase(userId: "32423");

      expect(result, const Right(true));

      verify(
        () => repository.checkUserExists(userId: any(named: "userId")),
      ).called(1);
    });

    test("Deve retornar um ErrorCheckUserExists de userId inválido", () async {
      var result = await usecase(userId: "");

      expect(result.leftMap((l) => l is ErrorCheckUserExists), const Left(true));

      verifyNever(
        () => repository.checkUserExists(userId: any(named: "userId")),
      );
    });

    test("Deve retornar um ErrorCheckUserExists", () async {
      when(
        () => repository.checkUserExists(userId: any(named: "userId")),
      ).thenAnswer((_) async => Left(ErrorCheckUserExists()));

      var result = await usecase(userId: "53453");

      expect(result.leftMap((l) => l is ErrorCheckUserExists), const Left(true));

      verify(
        () => repository.checkUserExists(userId: any(named: "userId")),
      ).called(1);
    });
  });
}
