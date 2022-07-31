import 'package:connectivity/connectivity.dart';
import 'package:fit_training_clean/app/modules/auth/data/drivers/conectivity_driver.dart';
import 'package:fit_training_clean/app/modules/auth/external/drivers/flutter_connectivity_driver_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ConnectivityMock extends Mock implements Connectivity {}

void main() {
  late Connectivity connectivity;
  late ConnectivityDriver driver;

  setUp(() {
    connectivity = ConnectivityMock();
    driver = FlutterConnectivityDriver(connectivity);
  });

  test("Deve retornar um bool mobile", () {
    when(() => connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.mobile);

    expect(driver.isOnline, completion(true));
  });

  test("Deve retornar um bool wifi", () {
    when(() => connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);

    expect(driver.isOnline, completion(true));
  });

  test("Deve retornar um bool false", () async {
    when(() => connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.none);

    expect(driver.isOnline, completion(false));
  });

  test("Deve retornar um bool false", () async {
    when(() => connectivity.checkConnectivity()).thenThrow(Exception());

    expect(driver.isOnline, throwsA(isA<Exception>()));
  });
}