import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/workout/domain/entities/workout_entity.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  @observable
  UserEntity? user;

  @action
  void setUser(UserEntity? value) => user = value;

  void setWorkout(List<WorkoutEntity> value) {
    setUser(user!.copyWith(workouts: value));
  }

  @computed
  bool get isLogged => user != null;
}
