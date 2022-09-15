import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_training_clean/app/core/modules/workout/data/datasources/workout_datasource.dart';
import 'package:fit_training_clean/app/core/modules/workout/data/models/workout_model.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';

class FirebaseFirestoreDatasource implements WorkoutDatasource {
  final FirebaseFirestore firestore;
  FirebaseFirestoreDatasource({required this.firestore});

  @override
  Future<void> updateWorkouts({required String uid, required List<WorkoutEntity> workouts}) async {
    
    List<WorkoutModel> list = (workouts as List<WorkoutModel>);

    List<Map<String, dynamic>> aux = list.map((workout) => workout.toMap()).toList();

    await firestore.collection(uid).doc(uid).update({"workouts" : aux});
  }
}
