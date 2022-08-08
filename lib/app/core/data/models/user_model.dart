import 'package:fit_training_clean/app/core/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/training/domain/entities/workout_entity.dart';

class UserModel extends UserEntity {
  UserModel(
    {
      required String name,
      required String email,
      required String photoUrl,
      required int amountDone,
      required int restTimeInSeconds,
      required List<WorkoutEntity> workouts
    }
  ) : super(
    name: name,
    email: email,
    photoUrl: photoUrl,
    amountDone: amountDone,
    restTimeInSeconds: restTimeInSeconds,
    workouts: workouts
  );

}