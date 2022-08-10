import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/get_logged_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

final UserEntity userEntityMock = UserEntity(
  uid: "1234",
  name: "Talis",
  email: "talismarchioro@gmail.com",
  photoUrl: "",
  amountDone: 0,
  restTimeInSeconds: 60,
  workouts: [],
);

void main() {
  late LoginRepository repository;
  late GetLoggedUserUsecase usecase;

  setUp(() {
    repository = LoginRepositoryMock();
    usecase = GetLoggedUserUsecaseImpl(repository: repository);
  });

  test("Verificar se existe usuario logado", () async {
    when(() => repository.loggedUser()).thenAnswer((_) async => Right(userEntityMock));

    var result = await usecase();

    expect(result, Right(userEntityMock));
  });

  test("Deve retornar null caso nao tenha usuario logado", () async {
    when(() => repository.loggedUser()).thenAnswer((_) async => Left(ErrorGetLoggedUser()));

    var result = await usecase();

    expect(result.fold(id, id), isA<ErrorGetLoggedUser>());
  });
}
