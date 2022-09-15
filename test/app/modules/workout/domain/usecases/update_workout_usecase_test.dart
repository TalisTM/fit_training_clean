import 'package:dartz/dartz.dart';
import 'package:fit_training_clean/app/modules/workout/domain/entities/workout_entity.dart';
import 'package:fit_training_clean/app/modules/workout/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/workout/domain/repositories/workout_repository.dart';
import 'package:fit_training_clean/app/modules/workout/domain/usecases/update_workout_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class WorkoutRepositoryMock extends Mock implements WorkoutRepository {}

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
  late UpdateWorkoutUsecase usecase;
  late WorkoutRepository repository;

  setUp(() {
    repository = WorkoutRepositoryMock();
    usecase = UpdateWorkoutUsecaseImpl(repository: repository);

    registerFallbackValue(listWorkoutEntityMock);
  });

  group("Quando o UpdateWorkoutUsecase for chamado", () {
    test("deve retornar sucesso", () async {
      when(
        () => repository.updateWorkouts(uid: any(named: "uid"), workouts: any(named: "workouts")),
      ).thenAnswer((_) async => const Right(unit));

      var result = await usecase(uid: "", workouts: listWorkoutEntityMock);

      expect(result, const Right(unit));
    });

    test("deve retornar um ErrorUpdateWorkout", () async {
      when(
        () => repository.updateWorkouts(uid: any(named: "uid"), workouts: any(named: "workouts")),
      ).thenAnswer((_) async => Left(ErrorUpdateWorkout()));

      var result = await usecase(uid: "", workouts: listWorkoutEntityMock);

      expect(result.leftMap((l) => l is ErrorUpdateWorkout), const Left(true));
    });
  });
}
