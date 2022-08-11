import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/core/auth/data/datasources/auth_datasource.dart';
import 'package:fit_training_clean/app/core/auth/data/models/user_model.dart';
import 'package:fit_training_clean/app/core/auth/domain/errors/errors.dart';

class FirebaseAuthDatasourceImpl implements AuthDatasource {
  final FirebaseAuth auth;
  FirebaseAuthDatasourceImpl({required this.auth});
 
  @override
  Future<UserModel> currentUser() async {
    var user = auth.currentUser;

    if (user == null) throw ErrorGetLoggedUser();

    return UserModel(
      uid: user.uid,
      name: user.displayName ?? "",
      email: user.email ?? "",
      photoUrl: user.photoURL ?? "",
      amountDone: 0,
      restTimeInSeconds: 60,
      workouts: [],
    );
  }

  @override
  Future<void> logout() async {
    return await auth.signOut();
  }
}
