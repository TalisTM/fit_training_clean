import 'package:fit_training_clean/app/core/auth/data/models/user_model.dart';

abstract class RegisterDatasource {
  Future<UserModel> registerEmail({required String email, required String password});
}