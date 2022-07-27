import 'package:fit_training_clean/app/modules/auth/data/models/user_model.dart';

abstract class LoginDatasource {
  Future<UserModel> loginEmail({required String email, required String password});

  Future<UserModel> loginGoogle({required String idToken, required String accessToken});

  Future<UserModel> currentUser();

  Future<void> logout();
}