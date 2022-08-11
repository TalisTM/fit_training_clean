import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/core/auth/data/models/user_model.dart';
import 'package:fit_training_clean/app/modules/login/data/datasources/login_datasource.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseLoginDatasourceImpl implements LoginDatasource {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  FirebaseLoginDatasourceImpl({required this.auth, required this.googleSignIn});
  
  @override
  Future<UserModel> loginEmail({required String email, required String password}) async {
    var result = await auth.signInWithEmailAndPassword(email: email, password: password);
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

  @override
  Future<UserModel> loginGoogle() async {
    var googleSignInAccount = await googleSignIn.signIn();
    var googleSignInAuthentication = await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    var result = await auth.signInWithCredential(credential);

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
