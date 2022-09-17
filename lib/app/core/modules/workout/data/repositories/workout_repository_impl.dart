import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/core/modules/workout/data/datasources/workout_datasource.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/repositories/workout_repository.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutDatasource datasource;
  WorkoutRepositoryImpl({required this.datasource});

  @override
  Future<Either<FailureWorkout, Unit>> updateWorkouts(
      {required String uid, required List<WorkoutEntity> workouts}) async {
    try {
      await datasource.updateWorkouts(uid: uid, workouts: workouts);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorUpdateWorkout(message: "Não foi possível cadastrar seu treino. \n$e"));
    }
  }
}
