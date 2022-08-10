import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/data/datasources/login_datasource.dart';
import 'package:fit_training_clean/app/modules/auth/data/models/google_authentication_model.dart';
import 'package:fit_training_clean/app/core/data/models/user_model.dart';
import 'package:fit_training_clean/app/modules/auth/data/repositories/login_repository_impl.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginDatasourceMock extends Mock implements LoginDatasource {}

final googleAuthenticationEntityMock = GoogleAuthenticationModel(
  idToken: "idToken",
  accessToken: "accessToken",
);

void main() {
  final userMock = UserModel(
    uid: "1234",
    name: "Talis",
    email: "talis@gmail.com",
    photoUrl: "photoUrl",
    amountDone: 0,
    restTimeInSeconds: 30,
    workouts: [],
  );

  late LoginRepository repository;
  late LoginDatasource datasource;

  setUp(() {
    datasource = LoginDatasourceMock();
    repository = LoginRepositoryImpl(datasource: datasource);
  });

  group("RegisterEmail", () {
    test("Deve retornar um UserModel", () async {
      when(
        () => datasource.registerEmail(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenAnswer((_) async => userMock);

      var result = await repository.registerEmail(
        email: "",
        password: "",
      );

      expect(result, Right(userMock));
    });

    test("Deve retornar um ErrorRegisterEmail", () async {
      when(
        () => datasource.registerEmail(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenThrow(ErrorRegisterEmail());

      var result = await repository.registerEmail(
        email: "",
        password: "",
      );

      expect(result.leftMap((l) => l is ErrorRegisterEmail), const Left(true));
    });
  });

  group("LoginEmail", () {
    test("Deve retornar um userModel", () async {
      when(
        () => datasource.loginEmail(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenAnswer((_) async => userMock);

      var result = await repository.loginEmail(email: '', password: '');
      expect(result, Right(userMock));
    });

    test("Deve retornar um ErrorLoginEmail", () async {
      when(
        () => datasource.loginEmail(
          email: any(named: "email"),
          password: any(named: "password"),
        ),
      ).thenThrow(ErrorLoginEmail());

      var result = await repository.loginEmail(email: '', password: '');

      expect(result.leftMap((l) => l is ErrorLoginEmail), const Left(true));
    });
  });

  group("GetGoogleAuthentication", () {
    test("Deve retornar um GoogleAuthenticationEntity", () async {
      when(
        () => datasource.getGoogleAuthentication(),
      ).thenAnswer((_) async => googleAuthenticationEntityMock);

      var result = await repository.getGoogleAuthentication();

      expect(result, Right(googleAuthenticationEntityMock));
    });

    test("Deve retornar um ErrorGoogleAuthentication", () async {
      when(
        () => datasource.getGoogleAuthentication(),
      ).thenThrow(ErrorGetGoogleAuthentication());

      var result = await repository.getGoogleAuthentication();

      expect(result.leftMap((l) => l is ErrorGetGoogleAuthentication), const Left(true));
    });
  });

  group("LoginGoogle", () {
    test("Deve retornar um userModel", () async {
      when(
        () => datasource.loginGoogle(
          accessToken: any(named: "accessToken"),
          idToken: any(named: "idToken"),
        ),
      ).thenAnswer((_) async => userMock);

      var result = await repository.loginGoogle(accessToken: '', idToken: '');
      expect(result, Right(userMock));
    });

    test("Deve retornar um ErrorLoginGoogle", () async {
      when(
        () => datasource.loginGoogle(
          accessToken: any(named: "accessToken"),
          idToken: any(named: "idToken"),
        ),
      ).thenThrow(ErrorLoginGoogle());

      var result = await repository.loginGoogle(accessToken: '', idToken: '');

      expect(result.leftMap((l) => l is ErrorLoginGoogle), const Left(true));
    });
  });

  group("LoggedUser", () {
    test("Deve retornar um userModel", () async {
      when(() => datasource.currentUser()).thenAnswer((_) async => userMock);

      var result = await repository.loggedUser();

      expect(result, Right(userMock));
    });

    test("Deve retornar um ErrorGetLoggedUser", () async {
      when(() => datasource.currentUser()).thenThrow(Left(ErrorGetLoggedUser()));

      var result = await repository.loggedUser();

      expect(result.leftMap((l) => l is ErrorGetLoggedUser), const Left(true));
    });
  });

  group("Logout", () {
    test("Deve fazer o logout", () async {
      when(() => datasource.logout()).thenAnswer((_) async {});

      var result = await repository.logout();

      expect(result, isA<Right<dynamic, Unit>>());
    });

    test("Deve retornar um ErrorLogout", () async {
      when(() => datasource.logout()).thenThrow(ErrorLogout());

      var result = await repository.logout();

      expect(result.leftMap((l) => l is ErrorLogout), const Left(true));
    });
  });
}
