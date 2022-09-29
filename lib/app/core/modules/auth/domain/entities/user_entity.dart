import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';

class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final int amountDone;
  final int restTimeInSeconds;
  final List<WorkoutEntity> workouts;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.amountDone,
    required this.restTimeInSeconds,
    required this.workouts,
  });

  UserEntity copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    int? amountDone,
    int? restTimeInSeconds,
    List<WorkoutEntity>? workouts,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      amountDone: amountDone ?? this.amountDone,
      restTimeInSeconds: restTimeInSeconds ?? this.restTimeInSeconds,
      workouts: workouts ?? this.workouts,
    );
  }
}
