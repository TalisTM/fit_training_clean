import 'package:fit_training_clean/app/core/modules/auth/presenter/stores/auth_store.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/usecases/update_workout_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'list_workouts_store.g.dart';

class ListWorkoutsStore = _ListWorkoutsStoreBase with _$ListWorkoutsStore;

abstract class _ListWorkoutsStoreBase with Store {
  final AuthStore authStore;
  final UpdateWorkoutUsecase updateWorkoutUsecase;
  _ListWorkoutsStoreBase({required this.updateWorkoutUsecase, required this.authStore});

  void onAddWorkout() {
    Modular.to.pushNamed("/crud-workout/crud");
  }

  void onEditWorkout() {
    Modular.to.pushNamed("/crud-workout/crud"); //passar o treino que quer editar
  }
}
