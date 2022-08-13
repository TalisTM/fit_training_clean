import 'package:fit_training_clean/app/core/modules/auth/data/models/exercise_model.dart';

class WorkoutEntity {
  final String name;
  final String content;
  final List<ExerciseModel> exercises;

  WorkoutEntity({required this.name, required this.content, required this.exercises});
}
