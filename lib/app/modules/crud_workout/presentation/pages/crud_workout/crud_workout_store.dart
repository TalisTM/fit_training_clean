import 'package:fit_training_clean/app/core/components/custom_dialog.dart';
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

  void onPressed(BuildContext context) async {
    if (!key.currentState!.validate()) return;
    if (workout.exercises.isEmpty) {
      await showDialog(
        context: context,
        builder: (context) => const CustomDialogWidget(
          title: "Atenção",
          content: "Adicione pelo menos um exercício ao treino",
          textPrimaryButton: "Ok",
        ),
      );
      return;
    }
    Modular.to.pop(workout);
  }

  // NAME
  @action
  void setName(String value) => setWorkout(workout.copyWith(name: value));

  String? validatorName(String? value) {
    if (value == null || value.isEmpty) {
      return "nome inválido";
    }
    return null;
  }

  // content
  @action
  void setContent(String value) => setWorkout(workout.copyWith(content: value));

  String? validatorContent(String? value) {
    if (value == null || value.isEmpty) {
      return "Descrição inválida";
    }
    return null;
  }
}
