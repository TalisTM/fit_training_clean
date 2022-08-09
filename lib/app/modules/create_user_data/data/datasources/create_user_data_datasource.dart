import 'package:fit_training_clean/app/core/data/models/user_model.dart';

abstract class CreateUserDataDatasouce {
  Future<bool> checkUserExists({required String userId});

  Future<UserModel> fetchExistingUser({required String userId});

  Future<void> saveNewUser({required UserModel user});
}
