import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/workout/data/datasources/workout_datasource.dart';
import 'package:fit_training_clean/app/modules/workout/data/repositories/workout_repository_impl.dart';
import 'package:fit_training_clean/app/modules/workout/domain/entities/workout_entity.dart';
import 'package:fit_training_clean/app/modules/workout/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/workout/domain/repositories/workout_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class WorkoutDatasourceMock extends Mock implements WorkoutDatasource {}

final List<WorkoutEntity> listWorkoutEntityMock = [
  WorkoutEntity(
    content: "peito",
    name: "Treino A",
    exercises: [],
  ),
  WorkoutEntity(
    content: "costas",
    name: "Treino B",
    exercises: [],
  )
];

void main() {
  late WorkoutRepository repository;
  late WorkoutDatasource datasource;

  setUp(() {
    datasource = WorkoutDatasourceMock();
    repository = WorkoutRepositoryImpl(datasource: datasource);

    registerFallbackValue(listWorkoutEntityMock);
  });

  group("updateWorkout,", () {
    test("deve retornar sucesso", () async {
      when(
        () => datasource.updateWorkouts(uid: any(named: "uid"), workouts: any(named: "workouts")),
      ).thenAnswer((_) async {});

      var result = await repository.updateWorkouts(uid: any(named: "uid"), workouts: listWorkoutEntityMock);

      expect(result, isA<Right<dynamic, Unit>>());
    });

    test("deve retornar um ErroUpdateWorkout", () async {
      when(
        () => datasource.updateWorkouts(uid: any(named: "uid"), workouts: any(named: "workouts")),
      ).thenThrow(Exception());

      var result = await repository.updateWorkouts(uid: any(named: "uid"), workouts: listWorkoutEntityMock);

      expect(result.leftMap((l) => l is ErrorUpdateWorkout), const Left(true));
    });
  });
}
