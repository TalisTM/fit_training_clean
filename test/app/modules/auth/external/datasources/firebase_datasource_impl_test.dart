import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/modules/auth/external/datasources/firebase_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class UserMock extends Mock implements User {}

class UserCredentialMock extends Mock implements UserCredential {}

class FirebaseAuthExceptionMock extends Mock implements FirebaseAuthException {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

final credential = UserCredentialMock();
final authException = FirebaseAuthExceptionMock();

void main() {
  final auth = FirebaseAuthMock();
  final firebaseUser = UserMock();
  final user = UserEntity(
    name: "Talis",
    email: "talismarchioro@gmail.com",
    photoUrl: "",
    amountDone: 0,
    restTimeInSeconds: 60,
    workouts: [],
  );

  final userCredential = UserCredentialMock();
  final datasource = FirebaseDatasourceImpl(auth: auth);

  setUpAll(() {
    when(() => firebaseUser.displayName).thenReturn("Talis");
    when(() => firebaseUser.email).thenReturn("talismarchioro@gmail.com");
    when(() => firebaseUser.photoURL).thenReturn("");
    when(() => userCredential.user).thenReturn(firebaseUser);

    when(
      () => auth.signInWithEmailAndPassword(
        email: any(named: "email"),
        password: any(named: "password"),
      ),
    ).thenAnswer((_) async => userCredential);

    when(
      () => auth.createUserWithEmailAndPassword(
        email: any(named: "email"),
        password: any(named: "password"),
      ),
    ).thenAnswer((_) async => userCredential);

    registerFallbackValue(const AuthCredential(
      providerId: "providerId",
      signInMethod: "signInMethod",
    ));
    when(() => auth.signInWithCredential(any())).thenAnswer((_) async => userCredential);
  });

  test("Deve retornar um userEntity via RegisterEmail", () async {
    var result = await datasource.registerEmail(email: "", password: "");

    expect(result.name, equals(user.name));
    expect(result.email, equals(user.email));
    expect(result.photoUrl, equals(user.photoUrl));
  });

  test("Deve retornar um UserEntity via loginEmail", () async {
    var result = await datasource.loginEmail(email: "", password: "");

    expect(result.name, equals(user.name));
    expect(result.email, equals(user.email));
    expect(result.photoUrl, equals(user.photoUrl));
  });

  test("Deve retornar um UserEntity via loginGoogle", () async {
    var result = await datasource.loginGoogle(idToken: "", accessToken: "");

    expect(result.name, equals(user.name));
    expect(result.email, equals(user.email));
    expect(result.photoUrl, equals(user.photoUrl));
  });

  test("Deve retornar um UserEntity via loggedUser", () async {
    when(() => auth.currentUser).thenAnswer((_) => firebaseUser);

    var result = await datasource.currentUser();

    expect(result.name, equals(user.name));
    expect(result.email, equals(user.email));
    expect(result.photoUrl, equals(user.photoUrl));
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
