import 'package:asuka/asuka.dart' as asuka;
import 'package:fit_training_clean/app/core/stores/auth_store.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final LoginWithEmailUsecase loginWithEmailUsecase;
  final LoginWithGoogleUsecase loginWithGoogleUsecase;
  final AuthStore authStore;

  _LoginStoreBase({
    required this.loginWithEmailUsecase,
    required this.loginWithGoogleUsecase,
    required this.authStore,
  });

  @observable
  String email = "";

  @action
  setEmail(String value) => email = value;

  @observable
  String password = "";

  @action
  setPassword(String value) => password = value;

  @computed
  LoginCredentials get credential => LoginCredentials.withEmailAndPassword(
        email: email,
        password: password,
      );

  @computed
  bool get isValid => credential.isValidEmail && credential.isValidPassword;

  enterEmail() async {
    // loading on
    var result = await loginWithEmailUsecase(credential);
    //loading off
    result.fold(
      (faulure) => asuka.showSnackBar(SnackBar(content: Text(faulure.message))),
      (user) {
        authStore.setUser(user);
        Modular.to.popUntil(ModalRoute.withName(Modular.initialRoute));
        Modular.to.pop();
      },
    );
  }

  enterGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    LoginCredentials credential = LoginCredentials.withGoogle(
      idToken: googleSignInAuthentication.idToken!,
      accessToken: googleSignInAuthentication.accessToken!,
    );

    //loading on
    var result = await loginWithGoogleUsecase(credential);
    //loading off
    result.fold(
      (faulure) => asuka.showSnackBar(SnackBar(content: Text(faulure.message))),
      (user) {
        authStore.setUser(user);
        Modular.to.popUntil(ModalRoute.withName(Modular.initialRoute));
        Modular.to.pop();
      },
    );
  }
}
