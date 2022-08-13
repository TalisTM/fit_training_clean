import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/modules/register/data/datasources/register_datasource.dart';
import 'package:fit_training_clean/app/modules/register/external/datasources/firebase_register_datasource_impl.dart';
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
  late RegisterDatasource datasource;

  setUpAll(() {
    auth = FirebaseAuthMock();
    firebaseUserMock = UserMock();
    userCredentialMock = UserCredentialMock();
    datasource = FirebaseRegisterDatasourceImpl(auth: auth);

    when(() => firebaseUserMock.uid).thenReturn("1234");
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
}
