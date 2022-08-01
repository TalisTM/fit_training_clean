import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/auth/data/drivers/conectivity_driver.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/domain/services/conectivity_service.dart';

class ConnectivityServiceImpl implements ConnectivityService {

  final ConnectivityDriver driver;
  ConnectivityServiceImpl({required this.driver});

  @override
  Future<Either<FailureUser, Unit>> isOnline() async {
    try {
      var check = await driver.isOnline;
      if(check) {
        return const Right(unit);
      }
      throw ConnectionError(message: "You are offline");
    } on FailureUser catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ConnectionError(message: "Error retrieving connection information"));
    }
  }

  
}