import 'package:fit_training_clean/app/core/modules/auth/data/models/user_model.dart';

abstract class AuthDatasource {
  Future<UserModel> currentUser();

  Future<void> logout();
}
