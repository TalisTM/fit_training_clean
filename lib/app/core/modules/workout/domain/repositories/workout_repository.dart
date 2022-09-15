import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/errors/errors.dart';

abstract class WorkoutRepository {
  Future<Either<FailureWorkout, Unit>> updateWorkouts({required String uid, required List<WorkoutEntity> workouts});
}
