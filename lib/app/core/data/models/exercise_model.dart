import 'dart:convert';

import 'package:fit_training_clean/app/core/domain/entities/exercise_entity.dart';

class ExerciseModel extends ExerciseEntity {
  ExerciseModel({
    required String name,
    required int numberSeries,
    required String numberRepetitions,
    required String weight,
    required bool hasChecked,
    required bool hasDone,
  }) : super(
          name: name,
          numberSeries: numberSeries,
          numberRepetitions: numberRepetitions,
          weight: weight,
          hasChecked: hasChecked,
          hasDone: hasDone,
        );
  
  
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'numberSeries': numberSeries});
    result.addAll({'numberRepetitions': numberRepetitions});
    result.addAll({'weight': weight});
    result.addAll({'hasChecked': hasChecked});
    result.addAll({'hasDone': hasDone});
  
    return result;
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      name: map['name'] ?? '',
      numberSeries: map['numberSeries']?.toInt() ?? 0,
      numberRepetitions: map['numberRepetitions'] ?? '',
      weight: map['weight'] ?? '',
      hasChecked: map['hasChecked'] ?? false,
      hasDone: map['hasDone'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseModel.fromJson(String source) => ExerciseModel.fromMap(json.decode(source));
}
