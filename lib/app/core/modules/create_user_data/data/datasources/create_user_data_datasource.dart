import 'package:fit_training_clean/app/core/modules/auth/data/models/user_model.dart';

abstract class CreateUserDataDatasouce {
  Future<UserModel> createUserData({required UserModel user});
}
