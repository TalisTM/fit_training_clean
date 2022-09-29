import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'crud_workout_store.g.dart';

class CrudWorkoutStore = _CrudWorkoutStoreBase with _$CrudWorkoutStore;

abstract class _CrudWorkoutStoreBase with Store {
  final key = GlobalKey<FormState>();

  @observable
  WorkoutEntity workout = WorkoutEntity(name: "", content: "", exercises: []);

  @action
  void setWorkout(WorkoutEntity value) => workout = value;

  void onPressed() {
    Modular.to.pop(workout);
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

  // NAME
  @observable
  String content = "";

  @action
  void setContent(String value) => content = value;

  String? validatorContent(String? value) {
    if (value == null || value.isEmpty) {
      return "nome inválido";
    }
    return null;
  }
}
