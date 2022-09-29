import 'package:fit_training_clean/app/core/modules/workout/domain/entities/exercise_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'crud_exercise_store.g.dart';

class CrudExerciseStore = _CrudExerciseStoreBase with _$CrudExerciseStore;

abstract class _CrudExerciseStoreBase with Store {
  final key = GlobalKey<FormState>();

  @observable
  ExerciseEntity exercise = ExerciseEntity(
    name: "",
    hasChecked: false,
    hasDone: false,
    numberRepetitions: "",
    numberSeries: 3,
    weight: "",
  );

  @action
  void setExercise(ExerciseEntity value) => exercise = value;

  void onPressed() {
    if (!key.currentState!.validate()) return;
    Modular.to.pop(exercise);
  }

  void onAddNumberSeries() {
    if (exercise.numberSeries <= 100) {
      setExercise(
        exercise.copyWith(numberSeries: exercise.numberSeries + 1),
      );
    }
  }

  void onReduceNumberSeries() {
    if (exercise.numberSeries > 1) {
      setExercise(
        exercise.copyWith(numberSeries: exercise.numberSeries - 1),
      );
    }
  }

  // NAME
  @observable
  String name = "";

  @action
  void setName(String value) => name = value;

  String? validatorName(String? value) {
    if (value == null || value.isEmpty) {
      return "nome inválido";
    }
    return null;
  }

  // numberRepetitions
  @observable
  String numberRepetitions = "";

  @action
  void setNumberRepetitions(String value) => numberRepetitions = value;

  String? validatorNumberRepetitions(String? value) {
    if (value == null || value.isEmpty) {
      return "Repetições inválida";
    }
    return null;
  }

  // WEIGHT
  @observable
  String weight = "";

  @action
  void setweight(String value) => name = value;

  String? validatorweight(String? value) {
    if (value == null) {
      return "peso inválido";
    }
    return null;
  }
}
