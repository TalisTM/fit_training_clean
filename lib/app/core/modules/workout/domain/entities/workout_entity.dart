import 'package:fit_training_clean/app/core/modules/workout/domain/entities/exercise_entity.dart';

class WorkoutEntity {
  final String name;
  final String content;
  final List<ExerciseEntity> exercises;

  WorkoutEntity({
    required this.name,
    required this.content,
    required this.exercises,
  });
}
