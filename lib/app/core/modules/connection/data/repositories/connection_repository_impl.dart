import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/connection/data/datasources/connection_datasource.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/repositories/connection_repository.dart';

class ConnectionRepositoryImpl implements ConnectionRepository {
  final ConnectionDatasource datasource;
  ConnectionRepositoryImpl({required this.datasource});

  @override
  Future<Either<FailureConnection, bool>> hasConnection() async {
    try {
      var result = await datasource.hasConnection();
      return Right(result);
    } catch (e) {
      return Left(ErrorConnection(message: "Verifique sua conexão e tente novamente."));
    }
  }
}
