import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';
import 'package:fit_training_clean/app/modules/register/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/register/domain/repositories/register_repository.dart';
import 'package:fit_training_clean/app/modules/register/domain/usecases/register_with_email_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class RegisterRepositoryMock extends Mock implements RegisterRepository {}

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

late LoginCredentials loginCredentialsMock = LoginCredentials.withEmailAndPassword(
  email: "talismarchioro@gmail.com",
  password: "123456",
);

void main() {
  late RegisterWithEmailUsecase usecase;
  late HasConnectionUsecase hasConnectionUsecase;
  late RegisterRepository repository;

  setUp(() {
    registerFallbackValue(loginCredentialsMock);
    repository = RegisterRepositoryMock();
    hasConnectionUsecase = HasConnectionUsecaseMock();
    usecase = RegisterWithEmailUsecaseImpl(
      repository: repository,
      hasConnectionUsecase: hasConnectionUsecase,
    );

    when(
      () => hasConnectionUsecase(),
    ).thenAnswer((_) async => const Right(true));

    when(
      () => repository.registerEmail(
        email: any(named: "email"),
        password: any(named: "password"),
      ),
    ).thenAnswer((_) async => const Right(userEntityMock));
  });

  group("Quando o RegisterWithEmailUsecase for chamado,", () {
    test("Deve retornar um UserEntity", () async {
      var result = await usecase(loginCredentialsMock);

      expect(result, const Right(userEntityMock));

      verify(
        () => repository.registerEmail(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).called(1);
    });

    test("Deve restonar um ErrorRegisterEmail", () async {
      List<String> inputEmail = ["", "fsdfsdfssdf", "talismarchioro", "@gmail.com", ".com"];
      for (String email in inputEmail) {
        loginCredentialsMock =
            LoginCredentials.withEmailAndPassword(email: email, password: "123456");
        var result = await usecase(loginCredentialsMock);
        expect(result.fold(id, id), isA<ErrorRegisterEmail>());
      }

      verifyNever(
        (() => repository.registerEmail(
              email: any(named: "email"),
              password: any(named: "password"),
            )),
      );
    });

    test("Deve retonar um ErrorRegisterEmail", () async {
      List<String> inputPassword = ["", "12", "123", "abc"];
      for (String password in inputPassword) {
        loginCredentialsMock = LoginCredentials.withEmailAndPassword(
          email: "talismarchioro@gmail.com",
          password: password,
        );

        var result = await usecase(loginCredentialsMock);

        expect(result.fold(id, id), isA<ErrorRegisterEmail>());
      }

      verifyNever(
        (() => repository.registerEmail(
              email: any(named: "email"),
              password: any(named: "password"),
            )),
      );
    });
  });
}
