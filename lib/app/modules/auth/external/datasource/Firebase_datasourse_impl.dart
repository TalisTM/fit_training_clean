import 'package:fit_training_clean/app/modules/auth/data/datasources/login_datasource.dart';
import 'package:fit_training_clean/app/modules/auth/data/models/user_model.dart';

class FirebaseDatasourceImpl implements LoginDatasource {
  @override
  Future<UserModel> currentUser() {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> loginEmail({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> loginGoogle({required String idToken, required String accessToken}) {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}