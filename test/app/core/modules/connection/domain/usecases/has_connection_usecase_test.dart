import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/repositories/connection_repository.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ConnectionRepositoryMock extends Mock implements ConnectionRepository {}

void main() {
  late HasConnectionUsecase usecase;
  late ConnectionRepository repository;

  setUp(() {
    repository = ConnectionRepositoryMock();
    usecase = HasConnectionUsecaseImpl(repository: repository);
  });

  group("Quando o HasConnectionUsecase for chamado,", () {
    test("deve retornar um bool", () async {
      when(
        () => repository.hasConnection(),
      ).thenAnswer((_) async => const Right(true));

      var result = await usecase();

      expect(result, const Right(true));
    });

    test("deve retotnar um ErrorConnection", () async {
      when(
        () => repository.hasConnection(),
      ).thenAnswer((invocation) async => Left(ErrorConnection()));

      var result = await usecase();

      expect(result.leftMap((l) => l is ErrorConnection), const Left(true));
    });
  });
}
