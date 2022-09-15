import 'package:fit_training_clean/app/modules/workout/domain/entities/workout_entity.dart';

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
}
