import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/repositories/workout_repository.dart';

abstract class UpdateWorkoutUsecase {
  Future<Either<FailureWorkout, Unit>> call({required String uid, required List<WorkoutEntity> workouts});
}

class UpdateWorkoutUsecaseImpl implements UpdateWorkoutUsecase {
  final WorkoutRepository repository;
  UpdateWorkoutUsecaseImpl({required this.repository});

  @override
  Future<Either<FailureWorkout, Unit>> call({required String uid, required List<WorkoutEntity> workouts}) async {
    var result = await repository.updateWorkouts(uid: uid, workouts: workouts);
    return result;
  }
}