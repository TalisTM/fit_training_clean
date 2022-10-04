import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';
import 'package:fit_training_clean/app/modules/login/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/login/domain/repositories/login_repository.dart';
import 'package:fit_training_clean/app/modules/login/domain/usecases/recover_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

class HasConnectionUsecaseMock extends Mock implements HasConnectionUsecase {}

void main() {
  late LoginRepository repository;
  late HasConnectionUsecase hasConnectionUsecase;
  late RecoverPasswordUsecase usecase;

  setUp(() {
    repository = LoginRepositoryMock();
    hasConnectionUsecase = HasConnectionUsecaseMock();
    usecase = RecoverPasswordUsecaseImpl(
      repository: repository,
      hasConnectionUsecase: hasConnectionUsecase,
    );

    when(
      () => hasConnectionUsecase(),
    ).thenAnswer((_) async => const Right(true));
  });

  group("Quando o RecoverPasswordUsecase for chamado,", () {
    test("deve retornar sucesso", () async {
      when(
        () => repository.recoverPassword(email: any(named: "email")),
      ).thenAnswer((_) async => const Right(unit));

      var result = await usecase(email: "talis@gmail.com");

      expect(result, const Right(unit));
    });

    test("deve retornar erro de email invalido", () async {
      when(
        () => repository.recoverPassword(email: any(named: "email")),
      ).thenAnswer((_) async => const Right(unit));

      var result = await usecase(email: "talis@g");

      expect(result.leftMap((l) => l is ErrorRecoverPassword), const Left(true));
    });
  });
}
