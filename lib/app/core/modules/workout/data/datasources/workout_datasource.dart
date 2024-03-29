
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';

abstract class WorkoutDatasource {
  Future<void> updateWorkouts({required String uid, required List<WorkoutEntity> workouts});
}
