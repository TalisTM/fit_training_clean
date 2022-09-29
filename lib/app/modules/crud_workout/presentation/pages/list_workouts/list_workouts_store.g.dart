// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_workouts_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListWorkoutsStore on _ListWorkoutsStoreBase, Store {
  late final _$workoutsAtom =
      Atom(name: '_ListWorkoutsStoreBase.workouts', context: context);

  @override
  ObservableList<WorkoutEntity> get workouts {
    _$workoutsAtom.reportRead();
    return super.workouts;
  }

  @override
  set workouts(ObservableList<WorkoutEntity> value) {
    _$workoutsAtom.reportWrite(value, super.workouts, () {
      super.workouts = value;
    });
  }

  late final _$_ListWorkoutsStoreBaseActionController =
      ActionController(name: '_ListWorkoutsStoreBase', context: context);

  @override
  void onDelete(int index) {
    final _$actionInfo = _$_ListWorkoutsStoreBaseActionController.startAction(
        name: '_ListWorkoutsStoreBase.onDelete');
    try {
      return super.onDelete(index);
    } finally {
      _$_ListWorkoutsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
workouts: ${workouts}
    ''';
  }
}
