import 'package:fit_training_clean/app/core/modules/auth/data/models/user_model.dart';

abstract class LoginDatasource {
  Future<UserModel> loginEmail({required String email, required String password});

  Future<UserModel> loginGoogle();
}
