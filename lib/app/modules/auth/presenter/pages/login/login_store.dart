import 'package:asuka/asuka.dart' as asuka;
import 'package:fit_training_clean/app/core/presenter/stores/auth_store.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/get_google_authentication_usecase.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/usecases/check_user_exists_usecase.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/usecases/fetch_existing_user_usecase.dart';
import 'package:fit_training_clean/app/modules/create_user_data/domain/usecases/save_new_user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final LoginWithEmailUsecase loginWithEmailUsecase;
  final LoginWithGoogleUsecase loginWithGoogleUsecase;
  final GetGoogleAuthenticationUsecase getGoogleAuthenticationUsecase;
  final CheckUserExistsUsecase checkUserExistsUsecase;
  final SaveNewUserUsecase saveNewUserUsecase;
  final FetchExistingUserUsecase fetchExistingUserUsecase;
  final AuthStore authStore;

  _LoginStoreBase({
    required this.loginWithEmailUsecase,
    required this.loginWithGoogleUsecase,
    required this.getGoogleAuthenticationUsecase,
    required this.checkUserExistsUsecase,
    required this.saveNewUserUsecase,
    required this.fetchExistingUserUsecase,
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

  void _showError(var failure) {
    asuka.showSnackBar(SnackBar(content: Text(failure.message)));
  }

  Future<void> enterEmail() async {
    // loading on
    var loginWithEmail = await loginWithEmailUsecase(credential);

    loginWithEmail.fold(
      (failure) => _showError(failure),
      (user) async {
        var checkUserExists = await checkUserExistsUsecase(userId: user.uid);

        checkUserExists.fold(
          (failure) => _showError(failure),
          (exists) async {
            if (!exists) {
              var saveNewUser = await saveNewUserUsecase(user: user);

              saveNewUser.fold(
                (failure) => _showError(failure),
                (_) {
                  authStore.setUser(user);
                  Modular.to.popUntil(ModalRoute.withName(Modular.initialRoute));
                  Modular.to.pop();
                },
              );
            }
          },
        );
      },
    );
    //loading off
  }

  Future<void> enterGoogle() async {
    var resultGoogle = await getGoogleAuthenticationUsecase();

    resultGoogle.fold(
      (failure) => asuka.showSnackBar(SnackBar(content: Text(failure.message))),
      (authentication) async {
        LoginCredentials credential = LoginCredentials.withGoogle(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken,
        );

        var result = await loginWithGoogleUsecase(credential);

        result.fold(
          (failure) => asuka.showSnackBar(SnackBar(content: Text(failure.message))),
          (user) {
            authStore.setUser(user);
            Modular.to.popUntil(ModalRoute.withName(Modular.initialRoute));
            Modular.to.pop();
          },
        );
      },
    );

    // final GoogleSignIn googleSignIn = GoogleSignIn();
    // final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    // final GoogleSignInAuthentication googleSignInAuthentication =
    //     await googleSignInAccount!.authentication;

    // LoginCredentials credential = LoginCredentials.withGoogle(
    //   idToken: googleSignInAuthentication.idToken!,
    //   accessToken: googleSignInAuthentication.accessToken!,
    // );

    // //loading on
    // var result = await loginWithGoogleUsecase(credential);
    // //loading off
    // result.fold(
    //   (failure) => asuka.showSnackBar(SnackBar(content: Text(failure.message))),
    //   (user) {
    //     authStore.setUser(user);
    //     Modular.to.popUntil(ModalRoute.withName(Modular.initialRoute));
    //     Modular.to.pop();
    //   },
    // );
  }
}
