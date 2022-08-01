import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}
void main() {
  
  late LoginRepository repository;
  late LogoutUsecase usecase;

  setUp(() {
    repository = LoginRepositoryMock();
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