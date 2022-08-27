import 'dart:convert';

import 'package:fit_training_clean/app/core/modules/auth/data/models/workout_model.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/workout_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String uid,
    required String name,
    required String email,
    required String photoUrl,
    required int amountDone,
    required int restTimeInSeconds,
    required List<WorkoutEntity> workouts,
  }) : super(
          uid: uid,
          name: name,
          email: email,
          photoUrl: photoUrl,
          amountDone: amountDone,
          restTimeInSeconds: restTimeInSeconds,
          workouts: workouts,
        );

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    int? amountDone,
    int? restTimeInSeconds,
    List<WorkoutEntity>? workouts,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      amountDone: amountDone ?? this.amountDone,
      restTimeInSeconds: restTimeInSeconds ?? this.restTimeInSeconds,
      workouts: workouts ?? this.workouts,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'photoUrl': photoUrl});
    result.addAll({'amountDone': amountDone});
    result.addAll({'restTimeInSeconds': restTimeInSeconds});
    result.addAll({'workouts': workouts.map((x) => (x as WorkoutModel).toMap()).toList()});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      amountDone: map['amountDone']?.toInt() ?? 0,
      restTimeInSeconds: map['restTimeInSeconds']?.toInt() ?? 0,
      workouts: List<WorkoutModel>.from(map['workouts']?.map((x) => WorkoutModel.fromMap(x))),
    );
  }

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
