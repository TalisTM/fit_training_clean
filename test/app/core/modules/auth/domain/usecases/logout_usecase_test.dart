import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/repositories/auth_repository.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  late AuthRepository repository;
  late LogoutUsecase usecase;

  setUp(() {
    repository = AuthRepositoryMock();
    usecase = LogoutUsecaseImpl(repository: repository);
  });

  test("Verificar se está logado", () async {
    when(() => repository.logout()).thenAnswer((_) async => const Right(unit));

    var result = await usecase();

    expect(result, const Right(unit));
  });

  test("Deve retornar erro se nao houver usuario logado", () async {
    when(() => repository.logout()).thenAnswer((_) async => Left(ErrorLogout()));

    var result = await usecase();

    expect(result.fold(id, id), isA<ErrorLogout>());
  });
}
