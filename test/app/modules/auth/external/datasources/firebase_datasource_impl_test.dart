import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/core/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/data/datasources/login_datasource.dart';
import 'package:fit_training_clean/app/modules/auth/data/models/google_authentication_model.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/external/datasources/firebase_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class UserMock extends Mock implements User {}

class UserCredentialMock extends Mock implements UserCredential {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class GoogleSignInMock extends Mock implements GoogleSignIn {}

class GoogleSignInAccountMock extends Mock implements GoogleSignInAccount {}

class GoogleSignInAuthenticationMock extends Mock implements GoogleSignInAuthentication {}

final userMock = UserEntity(
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

final googleAuthenticationModelMock = GoogleAuthenticationModel(
  idToken: "idToken",
  accessToken: "idToken",
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
    datasource = FirebaseDatasourceImpl(auth: auth, googleSignIn: googleSignIn);
    googleSignInAccount = GoogleSignInAccountMock();
    googleSignInAuthentication = GoogleSignInAuthenticationMock();

    when(() => firebaseUserMock.displayName).thenReturn("Talis");
    when(() => firebaseUserMock.email).thenReturn("talismarchioro@gmail.com");
    when(() => firebaseUserMock.photoURL).thenReturn("");
    when(() => userCredentialMock.user).thenReturn(firebaseUserMock);
  });

  test("Deve retornar um userEntity via RegisterEmail", () async {
    when(
      () => auth.createUserWithEmailAndPassword(
        email: any(named: "email"),
        password: any(named: "password"),
      ),
    ).thenAnswer((_) async => userCredentialMock);

    var result = await datasource.registerEmail(email: "", password: "");

    expect(result.name, equals(userMock.name));
    expect(result.email, equals(userMock.email));
    expect(result.photoUrl, equals(userMock.photoUrl));
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

  test("Deve retornar um GoogleAuthenticationModel via GetGoogleAuthentication", () async {
    when(() => googleSignIn.signIn()).thenAnswer((_) async => googleSignInAccount);
    when(
      () => googleSignInAccount.authentication,
    ).thenAnswer((_) async => googleSignInAuthentication);
    when(() => googleSignInAuthentication.idToken).thenReturn("idToken");
    when(() => googleSignInAuthentication.accessToken).thenReturn("accessToken");

    var result = await datasource.getGoogleAuthentication();

    expect(result, isA<GoogleAuthenticationModel>());
  });

  test("Deve retornar um UserEntity via loginGoogle", () async {
    registerFallbackValue(authCredentialMock);
    when(() => auth.signInWithCredential(any())).thenAnswer((_) async => userCredentialMock);

    var result = await datasource.loginGoogle(idToken: "", accessToken: "");

    expect(result.name, equals(userMock.name));
    expect(result.email, equals(userMock.email));
    expect(result.photoUrl, equals(userMock.photoUrl));
  });

  test("Deve retornar um UserEntity via loggedUser", () async {
    when(() => auth.currentUser).thenAnswer((_) => firebaseUserMock);

    var result = await datasource.currentUser();

    expect(result.name, equals(userMock.name));
    expect(result.email, equals(userMock.email));
    expect(result.photoUrl, equals(userMock.photoUrl));
  });

  test("Deve retornar um ErrorGetLoggedUser via loggedUser se não houver usuario logado", () async {
    when(() => auth.currentUser).thenAnswer((_) => null);

    var result = datasource.currentUser();

    expect(result, throwsA(isA<ErrorGetLoggedUser>()));
  });

  test("Deve deslogar com sucesso via Logout", () {
    when(() => auth.signOut()).thenAnswer((_) async {});

    var result = datasource.logout();
    expect(result, completes);
  });

  test("Deve returnar uma Exception via Logout", () {
    when(() => auth.signOut()).thenThrow(Exception());

    var result = datasource.logout();
    expect(result, throwsA(isA<Exception>()));
  });
}
