import 'package:fit_training_clean/app/core/modules/connection/connection_module.dart';
import 'package:fit_training_clean/app/core/modules/workout/workout_module.dart';
import 'package:fit_training_clean/app/modules/crud_workout/presentation/pages/crud_exercise/crud_exercise_store.dart';
import 'package:fit_training_clean/app/modules/crud_workout/presentation/pages/crud_workout/crud_workout_page.dart';
import 'package:fit_training_clean/app/modules/crud_workout/presentation/pages/crud_workout/crud_workout_store.dart';
import 'package:fit_training_clean/app/modules/crud_workout/presentation/pages/list_workouts/list_workouts_page.dart';
import 'package:fit_training_clean/app/modules/crud_workout/presentation/pages/list_workouts/list_workouts_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CrudWorkoutmodule extends Module {

  @override
  List<Bind<Object>> get binds => [
    Bind((i) => ListWorkoutsStore(updateWorkoutUsecase: i(), authStore: i())),
    Bind((i) => CrudWorkoutStore()),
    Bind((i) => CrudExerciseStore()),
  ];

  @override
  List<Module> get imports => [
    WorkoutModule(),
    ConnectionModule(),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute("/", child: (_, __) => const ListWorkoutsPage()),
    ChildRoute("/crud", child: (_, __) => const CrudWorkoutPage())
  ];
}
