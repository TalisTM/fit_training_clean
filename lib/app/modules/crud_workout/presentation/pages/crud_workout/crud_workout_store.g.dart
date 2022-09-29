// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crud_workout_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CrudWorkoutStore on _CrudWorkoutStoreBase, Store {
  late final _$workoutAtom =
      Atom(name: '_CrudWorkoutStoreBase.workout', context: context);

  @override
  WorkoutEntity get workout {
    _$workoutAtom.reportRead();
    return super.workout;
  }

  @override
  set workout(WorkoutEntity value) {
    _$workoutAtom.reportWrite(value, super.workout, () {
      super.workout = value;
    });
  }

  late final _$_CrudWorkoutStoreBaseActionController =
      ActionController(name: '_CrudWorkoutStoreBase', context: context);

  @override
  void setWorkout(WorkoutEntity value) {
    final _$actionInfo = _$_CrudWorkoutStoreBaseActionController.startAction(
        name: '_CrudWorkoutStoreBase.setWorkout');
    try {
      return super.setWorkout(value);
    } finally {
      _$_CrudWorkoutStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
workout: ${workout}
    ''';
  }
}
