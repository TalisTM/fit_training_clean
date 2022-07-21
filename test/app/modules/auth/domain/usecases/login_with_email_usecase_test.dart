import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:fit_training_clean/app/modules/auth/domain/services/conectivity_service.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}
class ConnectivityServiceMock extends Mock implements ConnectivityService {}

final UserEntity userEntityMock = UserEntity(name: "Talis", email: "talismarchioro@gmail.com", photoUrl: "", amountDone: 0, restTimeInSeconds: 60, workouts: []);
late LoginCredentials loginCredentialsMock = LoginCredentials.withEmailAndPassword(email: "talismarchioro@gmail.com", password: "1234");

void main() {
  
  late LoginRepository repository;
  late ConnectivityService service;
  late LoginWithEmailUsecase usecase;

  setUp(() {
    registerFallbackValue(loginCredentialsMock);
    repository = LoginRepositoryMock();
    service = ConnectivityServiceMock();
    usecase = LoginWithEmailUsecaseImpl(repository, service);
  });

  group("Quando chamar o LoginWithEmailUsecase,", () {
    test("Deve retonar um UserEntity", () async {
      when(() => repository.loginEmail(email: any(named: "email"), password: any(named: "password"))).thenAnswer((_) async => Right(userEntityMock));
      when(() => service.isOnline()).thenAnswer((_) async => const Right(unit));
      
      var result = await usecase(loginCredentialsMock);

      expect(result, Right(userEntityMock));
    });

    test("Deve retonar um ErrorLoginEmail", () async {
      when(() => repository.loginEmail(email: any(named: "email"), password: any(named: "password"))).thenAnswer((_) async => Right(userEntityMock));
      when(() => service.isOnline()).thenAnswer((_) async => const Right(unit));

      List<String> inputEmail = ["", "fsdfsdfssdf", "talismarchioro", "@gmail.com", ".com"];
      for(String email in inputEmail) {
        loginCredentialsMock = LoginCredentials.withEmailAndPassword(email: email, password: "1234");
        var result = await usecase(loginCredentialsMock);
        expect(result.fold(id, id), isA<ErrorLoginEmail>());
      }

      verifyNever((() => repository.loginEmail(email: any(named: "email"), password: any(named: "password"))));
    });

    test("Deve retonar um ErrorLoginPassword", () async {
      when(() => repository.loginEmail(email: any(named: "email"), password: any(named: "password"))).thenAnswer((_) async => Right(userEntityMock));
      when(() => service.isOnline()).thenAnswer((_) async => const Right(unit));

      List<String> inputPassword = ["", "12", "123", "abc"];
      for(String password in inputPassword) {
        loginCredentialsMock = LoginCredentials.withEmailAndPassword(email: "talismarchioro@gmail.com", password: password);
        var result = await usecase(loginCredentialsMock);
        expect(result.fold(id, id), isA<ErrorLoginEmail>());
      }

      verifyNever((() => repository.loginEmail(email: any(named: "email"), password: any(named: "password"))));
    });

    test("Deve retonar um ConnectionError quando offline", () async {
      when(() => repository.loginEmail(email: any(named: "email"), password: any(named: "password"))).thenAnswer((_) async => Right(userEntityMock));
      when(() => service.isOnline()).thenAnswer((_) async => Left(ConnectionError()));

      var result = await usecase(loginCredentialsMock);
      expect(result.fold(id, id), isA<ConnectionError>());

      verifyNever((() => repository.loginEmail(email: any(named: "email"), password: any(named: "password"))));
    });

  });
}