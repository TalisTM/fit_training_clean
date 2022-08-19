import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/connection/data/datasources/connection_datasource.dart';
import 'package:fit_training_clean/app/core/modules/connection/data/repositories/connection_repository_impl.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/repositories/connection_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ConnectionDatasourceMock extends Mock implements ConnectionDatasource {}

void main() {
  late ConnectionRepository repository;
  late ConnectionDatasource datasource;

  setUp(() {
    datasource = ConnectionDatasourceMock();
    repository = ConnectionRepositoryImpl(datasource: datasource);
  });

  group("Quando o ConnectionRepository.hasConnection() for chamado", () {
    test("deve retornar um bool", () async {
      when(
        () => datasource.hasConnection(),
      ).thenAnswer((_) async => true);

      var result = await repository.hasConnection();

      expect(result, const Right(true));
    });

    test("Deve retornar um ErrorConnection", () async {
      when(
        () => datasource.hasConnection(),
      ).thenThrow(Exception());

      var result = await repository.hasConnection();

      expect(result.leftMap((l) => l is ErrorConnection), const Left(true));
    });
  });
}
