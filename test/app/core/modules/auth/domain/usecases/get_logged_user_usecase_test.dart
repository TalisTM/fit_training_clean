import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/repositories/auth_repository.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/usecases/get_logged_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

const UserEntity userEntityMock = UserEntity(
  uid: "1234",
  name: "Talis",
  email: "talismarchioro@gmail.com",
  photoUrl: "",
  amountDone: 0,
  restTimeInSeconds: 60,
  workouts: [],
);

void main() {
  late AuthRepository repository;
  late GetLoggedUserUsecase usecase;

  setUp(() {
    repository = AuthRepositoryMock();
    usecase = GetLoggedUserUsecaseImpl(repository: repository);
  });

  test("Verificar se existe usuario logado", () async {
    when(() => repository.loggedUser()).thenAnswer((_) async => const Right(userEntityMock));

    var result = await usecase();

    expect(result, const Right(userEntityMock));
  });

  test("Deve retornar null caso nao tenha usuario logado", () async {
    when(() => repository.loggedUser()).thenAnswer((_) async => Left(ErrorGetLoggedUser()));

    var result = await usecase();

    expect(result.fold(id, id), isA<ErrorGetLoggedUser>());
  });
}
