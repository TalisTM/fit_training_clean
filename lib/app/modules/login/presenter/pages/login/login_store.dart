import 'package:asuka/asuka.dart' as asuka;
import 'package:fit_training_clean/app/core/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/auth/presenter/stores/auth_store.dart';
import 'package:fit_training_clean/app/core/create_user_data/domain/usecases/create_user_data_usecase.dart';
import 'package:fit_training_clean/app/core/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/modules/login/domain/usecases/login_with_email_usecase.dart';
import 'package:fit_training_clean/app/modules/login/domain/usecases/login_with_google_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final LoginWithEmailUsecase loginWithEmailUsecase;
  final LoginWithGoogleUsecase loginWithGoogleUsecase;
  final CreateUserDataUsecase createUserDataUsecase;
  final AuthStore authStore;

  _LoginStoreBase({
    required this.loginWithEmailUsecase,
    required this.loginWithGoogleUsecase,
    required this.createUserDataUsecase,
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
      (failure) => _showError,
      (user) => saveUserData
    );
    //loading off
  }

  Future<void> enterGoogle() async {
    var result = await loginWithGoogleUsecase();

    result.fold(
      (failure) => _showError,
      (user) => saveUserData
    );
  }

  Future<void> saveUserData(UserEntity user) async {
    var result = await createUserDataUsecase(user: user);

    result.fold(
      (failure) => _showError,
      (savedUser) {
        authStore.setUser(savedUser);
        Modular.to.popUntil(ModalRoute.withName(Modular.initialRoute));
        Modular.to.pop();
      },
    );
  }
}
