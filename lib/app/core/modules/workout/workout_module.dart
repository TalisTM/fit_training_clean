import 'package:fit_training_clean/app/core/modules/connection/connection_module.dart';
import 'package:fit_training_clean/app/core/modules/workout/data/repositories/workout_repository_impl.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/usecases/update_workout_usecase.dart';
import 'package:fit_training_clean/app/core/modules/workout/external/datasources/firebase_firestore_datasource.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WorkoutModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind(
          (i) => UpdateWorkoutUsecaseImpl(
            repository: i(),
            hasConnectionUsecase: i(),
          ),
          export: true,
        ),
        Bind((i) => WorkoutRepositoryImpl(datasource: i()), export: true),
        Bind((i) => FirebaseFirestoreDatasource(firestore: i()), export: true)
      ];

  @override
  List<Module> get imports => [
        ConnectionModule(),
      ];
}
