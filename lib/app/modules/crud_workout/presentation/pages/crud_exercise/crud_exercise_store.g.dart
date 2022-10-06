// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crud_exercise_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CrudExerciseStore on _CrudExerciseStoreBase, Store {
  late final _$exerciseAtom =
      Atom(name: '_CrudExerciseStoreBase.exercise', context: context);

  @override
  ExerciseEntity get exercise {
    _$exerciseAtom.reportRead();
    return super.exercise;
  }

  @override
  set exercise(ExerciseEntity value) {
    _$exerciseAtom.reportWrite(value, super.exercise, () {
      super.exercise = value;
    });
  }

  late final _$_CrudExerciseStoreBaseActionController =
      ActionController(name: '_CrudExerciseStoreBase', context: context);

  @override
  void setExercise(ExerciseEntity value) {
    final _$actionInfo = _$_CrudExerciseStoreBaseActionController.startAction(
        name: '_CrudExerciseStoreBase.setExercise');
    try {
      return super.setExercise(value);
    } finally {
      _$_CrudExerciseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
exercise: ${exercise}
    ''';
  }
}
