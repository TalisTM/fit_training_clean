import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';
import 'package:fit_training_clean/app/modules/login/domain/repositories/login_repository.dart';
import 'package:fit_training_clean/app/modules/login/domain/usecases/login_with_google_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class HasConnectionUsecaseMock extends Mock implements HasConnectionUsecase {}

const UserEntity userEntityMock = UserEntity(
  uid: "1234",
  name: "Talis",
  email: "talismarchioro@gmail.com",
  photoUrl: "",
  amountDone: 0,
  restTimeInSeconds: 60,
  workouts: [],
);

LoginCredentials loginCredentialsMock = LoginCredentials.withGoogle(
  idToken: "idToken",
  accessToken: "accessToken",
);

void main() {
  late LoginRepository repository;
  late HasConnectionUsecase hasConnectionUsecase;
  late LoginWithGoogleUsecase usecase;

  setUp(() {
    repository = LoginRepositoryMock();
    hasConnectionUsecase = HasConnectionUsecaseMock();
    usecase = LoginWithGoogleUsecaseImpl(
      repository: repository,
      hasConnectionUsecase: hasConnectionUsecase,
    );

    when(
      () => hasConnectionUsecase(),
    ).thenAnswer((_) async => const Right(true));

    when(
      () => repository.loginGoogle(),
    ).thenAnswer((_) async => const Right(userEntityMock));
  });

  group("Quando o usecase for chamado,", () {
    test("Deve retornar um UserEntity", () async {
      var result = await usecase();

      expect(result, const Right(userEntityMock));

      verify(() => repository.loginGoogle()).called(1);
    });
  });
}
