import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:fit_training_clean/app/modules/auth/domain/services/conectivity_service.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}
class ConnectivityServiceMock extends Mock implements ConnectivityService {}

final UserEntity userEntityMock = UserEntity(name: "Talis", email: "talismarchioro@gmail.com", photoUrl: "", amountDone: 0, restTimeInSeconds: 60, workouts: []);

LoginCredentials loginCredentialsMock = LoginCredentials.withGoogle(idToken: "idToken", accessToken: "accessToken");

void main() {
  
  late LoginRepository repository;
  late ConnectivityService service;
  late LoginWithGoogle usecase;

  setUp(() {
    repository = LoginRepositoryMock();
    service = ConnectivityServiceMock();
    usecase = LoginWithGoogleImpl(repository, service);

    when(() => repository.loginGoogle(idToken: any(named: "idToken"), accessToken: any(named: "accessToken"))).thenAnswer((_) async => Right(userEntityMock));
    when(() => service.isOnline()).thenAnswer((_) async => const Right(unit));
  });

  group("Quando o usecase for chamado,", () {
    test("Deve retornar um UserEntity", () async {
      var result = await usecase(loginCredentialsMock);

      expect(result, Right(userEntityMock));

      verify(() => repository.loginGoogle(idToken: any(named: "idToken"), accessToken: any(named: "accessToken"))).called(1);
    });

    test("Deve retornar um ErrorLoginGoogle quando o idToken for inválido", () async {
      loginCredentialsMock = LoginCredentials.withGoogle(idToken: "", accessToken: "accessToken");
      var result = await usecase(loginCredentialsMock);

      expect(result.fold(id, id), isA<ErrorLoginGoogle>());

      verifyNever(() => repository.loginGoogle(idToken: any(named: "idToken"), accessToken: any(named: "accessToken")));
    });

    test("Deve retornar um ErrorLoginGoogle quando o accessToken for inválido", () async {
      loginCredentialsMock = LoginCredentials.withGoogle(idToken: "idToken", accessToken: "");
      var result = await usecase(loginCredentialsMock);

      expect(result.fold(id, id), isA<ErrorLoginGoogle>());

      verifyNever(() => repository.loginGoogle(idToken: any(named: "idToken"), accessToken: any(named: "accessToken")));
    });

    test("Deve retornar um ConnectionError quando offline", () async {
      when(() => service.isOnline()).thenAnswer((_) async => Left(ConnectionError()));

      var result = await usecase(loginCredentialsMock);

      expect(result.fold(id, id), isA<ConnectionError>());

      verifyNever(() => repository.loginGoogle(idToken: any(named: "idToken"), accessToken: any(named: "accessToken")));
    });
  });
}