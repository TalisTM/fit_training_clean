import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/repositories/workout_repository.dart';
import 'package:fit_training_clean/app/core/utils/utils.dart';

abstract class UpdateWorkoutUsecase {
  Future<Either<FailureWorkout, Unit>> call({
    required String uid,
    required List<WorkoutEntity> workouts,
  });
}

class UpdateWorkoutUsecaseImpl implements UpdateWorkoutUsecase {
  final WorkoutRepository repository;
  final HasConnectionUsecase hasConnectionUsecase;
  UpdateWorkoutUsecaseImpl({required this.repository, required this.hasConnectionUsecase});

  @override
  Future<Either<FailureWorkout, Unit>> call({
    required String uid,
    required List<WorkoutEntity> workouts,
  }) async {
    String? hasConnection = await Utils.connection.hasConnection(hasConnectionUsecase);
    if (hasConnection != null) {
      return Left(ErrorUpdateWorkout(message: hasConnection));
    }

    var result = await repository.updateWorkouts(uid: uid, workouts: workouts);
    return result;
  }
}
