import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/core/auth/data/datasources/auth_datasource.dart';
import 'package:fit_training_clean/app/core/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/auth/domain/errors/errors.dart';
import 'package:fit_training_clean/app/core/auth/external/datasources/firebase_auth_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class UserMock extends Mock implements User {}

class UserCredentialMock extends Mock implements UserCredential {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

final userMock = UserEntity(
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
  late AuthDatasource datasource;

  setUpAll(() {
    auth = FirebaseAuthMock();
    firebaseUserMock = UserMock();
    userCredentialMock = UserCredentialMock();
    datasource = FirebaseAuthDatasourceImpl(auth: auth);

    when(() => firebaseUserMock.uid).thenReturn("1234");
    when(() => firebaseUserMock.displayName).thenReturn("Talis");
    when(() => firebaseUserMock.email).thenReturn("talismarchioro@gmail.com");
    when(() => firebaseUserMock.photoURL).thenReturn("");
    when(() => userCredentialMock.user).thenReturn(firebaseUserMock);
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
