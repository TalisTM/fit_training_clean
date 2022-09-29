import 'package:fit_training_clean/app/core/modules/auth/presenter/stores/auth_store.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/usecases/update_workout_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'list_workouts_store.g.dart';

class ListWorkoutsStore = _ListWorkoutsStoreBase with _$ListWorkoutsStore;

abstract class _ListWorkoutsStoreBase with Store {
  final AuthStore authStore;
  final UpdateWorkoutUsecase updateWorkoutUsecase;
  _ListWorkoutsStoreBase({required this.updateWorkoutUsecase, required this.authStore});

  @observable
  ObservableList<WorkoutEntity> workouts = ObservableList.of(
    Modular.get<AuthStore>().user!.workouts,
  );

  void onAddWorkout() async {
    var result = await Modular.to.pushNamed("/crud-workout/crud");

    if (result != null) {
      workouts.add(result as WorkoutEntity);
      saveWorkout();
    }
  }

  void onEditWorkout(int index) async {
    var result = await Modular.to.pushNamed("/crud-workout/crud", arguments: workouts[index]);

    if (result != null) {
      workouts[index] = (result as WorkoutEntity);
      saveWorkout();
    }
  }

  @action
  void onDelete(int index) {
    workouts.removeAt(index);
    saveWorkout();
  }

  void saveWorkout() async {
    var result = await updateWorkoutUsecase(uid: authStore.user!.uid, workouts: workouts);

    result.fold(
      (l) {
        //mostrar erro na tela

        workouts = ObservableList.of(authStore.user!.workouts);
      },
      (_) {
        authStore.setWorkout(workouts);
      },
    );
  }
}
