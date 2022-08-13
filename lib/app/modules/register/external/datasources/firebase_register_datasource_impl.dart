import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/core/modules/auth/data/models/user_model.dart';
import 'package:fit_training_clean/app/modules/register/data/datasources/register_datasource.dart';

class FirebaseRegisterDatasourceImpl implements RegisterDatasource {
  final FirebaseAuth auth;
  FirebaseRegisterDatasourceImpl({required this.auth});

  @override
  Future<UserModel> registerEmail({required String email, required String password}) async {
    var result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    var user = result.user;

    return UserModel(
      uid: user!.uid,
      name: user.displayName ?? "",
      email: user.email ?? "",
      photoUrl: user.photoURL ?? "",
      amountDone: 0,
      restTimeInSeconds: 60,
      workouts: [],
    );
  }
}
