import 'dart:convert';

import 'package:fit_training_clean/app/core/modules/workout/data/models/exercise_model.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';


class WorkoutModel extends WorkoutEntity {
  WorkoutModel({
    required String name,
    required String content,
    required List<ExerciseModel> exercises,
  }) : super(
          name: name,
          content: content,
          exercises: exercises,
        );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'content': content});
    result.addAll({'exercises': exercises.map((x) => (x as ExerciseModel).toMap()).toList()});

    return result;
  }

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      name: map['name'] ?? '',
      content: map['content'] ?? '',
      exercises: List<ExerciseModel>.from(map['exercises']?.map((x) => ExerciseModel.fromMap(x))),
    );
  }

  factory WorkoutModel.fromEntity(WorkoutEntity entity) {
    return WorkoutModel(
      name: entity.name,
      content: entity.content,
      exercises: List<ExerciseModel>.from(entity.exercises.map((x) => ExerciseModel.fromEntity(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkoutModel.fromJson(String source) => WorkoutModel.fromMap(json.decode(source));
}
