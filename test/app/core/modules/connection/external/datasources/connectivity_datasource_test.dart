import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fit_training_clean/app/core/modules/connection/data/datasources/connection_datasource.dart';
import 'package:fit_training_clean/app/core/modules/connection/external/datasources/connectivity_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ConnectivityMock extends Mock implements Connectivity {}

main() {
  late Connectivity connectivity;
  late ConnectionDatasource datasource;

  setUp(() {
    connectivity = ConnectivityMock();
    datasource = ConnectivityDatasource(connectivity: connectivity);
  });

  test('should return bool mobile', () async {
    when(() => connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.mobile);

    expect(datasource.hasConnection(), completion(true));
  });

  test('should return bool wifi', () async {
    when(() => connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);

    expect(datasource.hasConnection(), completion(true));
  });

  test('should return bool false', () async {
    when(() => connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.none);

    expect(datasource.hasConnection(), completion(false));
  });

  test('should return bool false', () async {
    when(() => connectivity.checkConnectivity()).thenThrow(Exception());

    expect(datasource.hasConnection(), throwsA(isA<Exception>()));
  });
}
