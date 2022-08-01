import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/data/drivers/conectivity_driver.dart';
import 'package:fit_training_clean/app/modules/auth/data/services/connectivity_service_impl.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/services/conectivity_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ConnectivityDriverMock extends Mock implements ConnectivityDriver {}
void main() {
  late ConnectivityDriver driver;
  late ConnectivityService service;

  setUp(() {
    driver = ConnectivityDriverMock();
    service = ConnectivityServiceImpl(driver: driver);
  });

    group("ConnectivityServiceImpl", () {
      test("Deve retornar um bool", () async {
        when(() => driver.isOnline).thenAnswer((_) async => true);
        
        var result = await service.isOnline();

        expect(result, isA<Right<dynamic, Unit>>());
      });

      test("Deve retornar um ErrorConnection", () async {
        when(() => service.isOnline()).thenThrow(ConnectionError());

        var result = await service.isOnline();

        expect(result.leftMap((l) => l is ConnectionError), const Left(true));
      });
    });
}