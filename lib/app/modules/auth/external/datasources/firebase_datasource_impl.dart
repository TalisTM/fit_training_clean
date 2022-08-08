import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/modules/auth/data/datasources/login_datasource.dart';
import 'package:fit_training_clean/app/modules/auth/data/models/google_authentication_model.dart';
import 'package:fit_training_clean/app/core/data/models/user_model.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseDatasourceImpl implements LoginDatasource {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  FirebaseDatasourceImpl({required this.auth, required this.googleSignIn});

  @override
  Future<UserModel> registerEmail({required String email, required String password}) async {
    var result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    var user = result.user;

    return UserModel(
      name: user!.displayName ?? "",
      email: user.email ?? "",
      photoUrl: user.photoURL ?? "",
      amountDone: 0,
      restTimeInSeconds: 60,
      workouts: [],
    );
  }

  @override
  Future<UserModel> loginEmail({required String email, required String password}) async {
    var result = await auth.signInWithEmailAndPassword(email: email, password: password);
    var user = result.user;

    return UserModel(
      name: user!.displayName ?? "",
      email: user.email ?? "",
      photoUrl: user.photoURL ?? "",
      amountDone: 0,
      restTimeInSeconds: 60,
      workouts: [],
    );
  }

  @override
  Future<GoogleAuthenticationModel> getGoogleAuthentication() async {
    var googleSignInAccount = await googleSignIn.signIn();
    var googleSignInAuthentication = await googleSignInAccount!.authentication;

    return GoogleAuthenticationModel(
      idToken: googleSignInAuthentication.idToken!,
      accessToken: googleSignInAuthentication.accessToken!,
    );
  }

  @override
  Future<UserModel> loginGoogle({required String idToken, required String accessToken}) async {
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: idToken,
      accessToken: accessToken,
    );
    var result = await auth.signInWithCredential(credential);

    var user = result.user;

    return UserModel(
      name: user!.displayName ?? "",
      email: user.email ?? "",
      photoUrl: user.photoURL ?? "",
      amountDone: 0,
      restTimeInSeconds: 60,
      workouts: [],
    );
  }

  @override
  Future<UserModel> currentUser() async {
    var user = auth.currentUser;

    if (user == null) throw ErrorGetLoggedUser();

    return UserModel(
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
