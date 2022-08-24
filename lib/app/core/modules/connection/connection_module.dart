import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fit_training_clean/app/core/modules/connection/data/repositories/connection_repository_impl.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';
import 'package:fit_training_clean/app/core/modules/connection/external/datasources/connectivity_datasource.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConnectionModule extends Module {
  @override
  List<Bind<Object>> get binds => [
    Bind((i) => Connectivity(), export: true),
    Bind((i) => HasConnectionUsecaseImpl(repository: i()), export: true),
    Bind((i) => ConnectionRepositoryImpl(datasource: i()), export: true),
    Bind((i) => ConnectivityDatasource(connectivity: i()), export: true)
  ];
}