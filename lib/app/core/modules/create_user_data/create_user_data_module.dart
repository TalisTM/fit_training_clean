import 'package:fit_training_clean/app/core/modules/create_user_data/data/repositories/create_user_data_repository_impl.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/domain/usecases/create_user_data_usecase.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/external/datasources/firebase_firestore_datasource_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateUserDataModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => CreateUserDataUsecaseImpl(repository: i()), export: true),
        Bind((i) => CreateUserDataRepositoryImpl(datasouce: i()), export: true),
        Bind((i) => FirebaseFirestoreDatasourceImpl(firestore: i()), export: true),
      ];
}
