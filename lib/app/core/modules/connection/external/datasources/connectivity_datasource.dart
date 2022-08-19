import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fit_training_clean/app/core/modules/connection/data/datasources/connection_datasource.dart';

class ConnectivityDatasource implements ConnectionDatasource {
  final Connectivity connectivity;
  ConnectivityDatasource({required this.connectivity});

  @override
  Future<bool> hasConnection() async {
    var connectivityResult = await connectivity.checkConnectivity();

    return connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;
  }
}
