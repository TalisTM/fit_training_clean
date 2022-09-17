import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';
import 'package:mobx/mobx.dart';

part 'crud_workout_store.g.dart';

class CrudWorkoutStore = _CrudWorkoutStoreBase with _$CrudWorkoutStore;

abstract class _CrudWorkoutStoreBase with Store {
  @observable
  WorkoutEntity workout = WorkoutEntity(name: "", content: "", exercises: []);

  @action
  void setWorkout(WorkoutEntity value) => workout = value;
}
