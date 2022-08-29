import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/login/data/datasources/login_datasource.dart';
import 'package:fit_training_clean/app/modules/login/external/datasources/firebase_login_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class UserMock extends Mock implements User {}

class UserCredentialMock extends Mock implements UserCredential {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class GoogleSignInMock extends Mock implements GoogleSignIn {}

class GoogleSignInAccountMock extends Mock implements GoogleSignInAccount {}

class GoogleSignInAuthenticationMock extends Mock implements GoogleSignInAuthentication {}

const userMock = UserEntity(
  uid: "1234",
  name: "Talis",
  email: "talismarchioro@gmail.com",
  photoUrl: "",
  amountDone: 0,
  restTimeInSeconds: 60,
  workouts: [],
);

const authCredentialMock = AuthCredential(
  providerId: "providerId",
  signInMethod: "signInMethod",
);

void main() {
  late FirebaseAuth auth;
  late User firebaseUserMock;
  late UserCredential userCredentialMock;
  late LoginDatasource datasource;
  late GoogleSignIn googleSignIn;
  late GoogleSignInAccount googleSignInAccount;
  late GoogleSignInAuthentication googleSignInAuthentication;

  setUpAll(() {
    auth = FirebaseAuthMock();
    firebaseUserMock = UserMock();
    userCredentialMock = UserCredentialMock();
    googleSignIn = GoogleSignInMock();
    datasource = FirebaseLoginDatasourceImpl(auth: auth, googleSignIn: googleSignIn);
    googleSignInAccount = GoogleSignInAccountMock();
    googleSignInAuthentication = GoogleSignInAuthenticationMock();

    when(() => firebaseUserMock.uid).thenReturn("1234");
    when(() => firebaseUserMock.displayName).thenReturn("Talis");
    when(() => firebaseUserMock.email).thenReturn("talismarchioro@gmail.com");
    when(() => firebaseUserMock.photoURL).thenReturn("");
    when(() => userCredentialMock.user).thenReturn(firebaseUserMock);
  });

  test("Deve retornar um UserEntity via loginEmail", () async {
    when(
      () => auth.signInWithEmailAndPassword(
        email: any(named: "email"),
        password: any(named: "password"),
      ),
    ).thenAnswer((_) async => userCredentialMock);

    var result = await datasource.loginEmail(email: "", password: "");

    expect(result.name, equals(userMock.name));
    expect(result.email, equals(userMock.email));
    expect(result.photoUrl, equals(userMock.photoUrl));
  });

  test("Deve retornar um UserEntity via loginGoogle", () async {
    registerFallbackValue(authCredentialMock);

    when(() => googleSignIn.signIn()).thenAnswer((_) async => googleSignInAccount);
    when(
      () => googleSignInAccount.authentication,
    ).thenAnswer((_) async => googleSignInAuthentication);
    when(() => googleSignInAuthentication.idToken).thenReturn("idToken");
    when(() => googleSignInAuthentication.accessToken).thenReturn("accessToken");

    when(() => auth.signInWithCredential(any())).thenAnswer((_) async => userCredentialMock);

    var result = await datasource.loginGoogle();

    expect(result.name, equals(userMock.name));
    expect(result.email, equals(userMock.email));
    expect(result.photoUrl, equals(userMock.photoUrl));
  });

  test("Deve retornar sucesso via RecoverPassword", () {
    when(
      () => auth.sendPasswordResetEmail(email: any(named: "email")),
    ).thenAnswer((_) async => {});

    var result = datasource.recoverPassword(email: "talis@gmail.com");

    expect(result, completes);
  });

  test("Deve retornar ErrorRecoverPassword via RecoverPassword", () {
    when(
      () => auth.sendPasswordResetEmail(email: any(named: "email")),
    ).thenThrow(Exception());

    var result = datasource.recoverPassword(email: "talis@gmail.com");

    expect(result, throwsA(isA<Exception>()));
  });
}
