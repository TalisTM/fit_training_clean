import 'package:fit_training_clean/app/modules/training/domain/entities/workout_entity.dart';

class UserEntity {
  final String name;
  final String email;
  final String photoUrl;
  final int amountDone;
  final int restTimeInSeconds;
  final List<WorkoutEntity> workouts;

  UserEntity({required this.name, required this.email, required this.photoUrl, required this.amountDone, required this.restTimeInSeconds, required this.workouts});

}