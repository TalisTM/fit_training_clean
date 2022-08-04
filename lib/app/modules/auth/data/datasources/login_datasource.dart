import 'package:fit_training_clean/app/modules/auth/data/models/google_authentication_model.dart';
import 'package:fit_training_clean/app/modules/auth/data/models/user_model.dart';

abstract class LoginDatasource {
  Future<UserModel> registerEmail({required String email, required String password});

  Future<UserModel> loginEmail({required String email, required String password});

  Future<GoogleAuthenticationModel> getGoogleAuthentication();

  Future<UserModel> loginGoogle({required String idToken, required String accessToken});

  Future<UserModel> currentUser();

  Future<void> logout();
}
