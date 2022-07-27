import 'package:connectivity/connectivity.dart';
import 'package:fit_training_clean/app/modules/auth/data/drivers/conectivity_driver.dart';

class FlutterConnectivityDriver implements ConnectivityDriver {
  final Connectivity connectivity;

  FlutterConnectivityDriver(this.connectivity);
  
  @override
  Future<bool> get isOnline async {
    var result = await connectivity.checkConnectivity();
    return result == ConnectivityResult.wifi || result == ConnectivityResult.mobile;
  }
}