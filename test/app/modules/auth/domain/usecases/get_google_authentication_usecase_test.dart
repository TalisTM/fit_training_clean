import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/google_authentication_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/get_google_authentication_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

final GoogleAuthenticationEntity googleAuthenticationEntityMock = GoogleAuthenticationEntity(
  idToken: "idToken",
  accessToken: "accessToken",
);

void main() {
  late LoginRepository repository;
  late GetGoogleAuthenticationUsecase usecase;

  setUp(() {
    repository = LoginRepositoryMock();
    usecase = GetGoogleAuthenticationUsecaseImpl(repository: repository);
  });

  group("Quando o GetGoogleAuthenticationUsecase for chamado,", () {
    test("Deve retornar um GoogleAuthenticationEntity", () async {
      when(
        () => repository.getGoogleAuthentication(),
      ).thenAnswer((_) async => Right(googleAuthenticationEntityMock));

      var result = await usecase();

      expect(result, Right(googleAuthenticationEntityMock));
    });

    test("Deve retornar um ErrorGetGoogleAuthentication", () async {
      when(
        () => repository.getGoogleAuthentication(),
      ).thenAnswer((_) async => Left(ErrorGetGoogleAuthentication()));

      var result = await usecase();

      expect(result.leftMap((l) => l is ErrorGetGoogleAuthentication), const Left(true));
    });
  });
}
