import 'package:fit_training_clean/app/core/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/auth/presenter/stores/auth_store.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/domain/usecases/create_user_data_usecase.dart';
import 'package:fit_training_clean/app/core/utils/status.dart';
import 'package:fit_training_clean/app/core/utils/utils.dart';
import 'package:fit_training_clean/app/modules/login/domain/usecases/login_with_email_usecase.dart';
import 'package:fit_training_clean/app/modules/login/domain/usecases/login_with_google_usecase.dart';
import 'package:fit_training_clean/app/modules/login/domain/usecases/recover_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final HasConnectionUsecase hasConnectionUsecase;
  final LoginWithEmailUsecase loginWithEmailUsecase;
  final LoginWithGoogleUsecase loginWithGoogleUsecase;
  final CreateUserDataUsecase createUserDataUsecase;
  final AuthStore authStore;

  _LoginStoreBase({
    required this.hasConnectionUsecase,
    required this.loginWithEmailUsecase,
    required this.loginWithGoogleUsecase,
    required this.createUserDataUsecase,
    required this.authStore,
  });

  final key = GlobalKey<FormState>();

  // EMAIL
  @observable
  String email = "";

  @action
  void setEmail(String value) => email = value;

  String? validatorEmail(String? string) {
    if (!credential.isValidEmail) {
      return "E-mail inválido";
    }
    return null;
  }

  // PASSWORD
  @observable
  String password = "";

  @action
  void setPassword(String value) => password = value;

  String? validatorPassword(String? string) {
    if (!credential.isValidPassword) {
      return "Senha inválida";
    }
    return null;
  }

  // HIDE PASSWORD
  @observable
  bool hidePassword = true;

  @action
  void setHidePassowrd(bool value) => hidePassword = value;

  // STATUS
  @observable
  Status status = Status.initial;

  @action
  void setStatus(Status value) => status = value;

  //FAILURE TEXT
  @observable
  String? failureText;

  @action
  void setFailureText(String value) {
    setStatus(Status.failure);
    failureText = value;
  }

  @computed
  LoginCredentials get credential => LoginCredentials.withEmailAndPassword(
        email: email,
        password: password,
      );

  Future<bool> get _hasConnection async => await Utils.connection.hasConnection(
        hasConnectionUsecase,
      );

  void onEnterEmail() {
    if (!key.currentState!.validate()) return;
    requestEnterEmail();
  }

  Future<void> requestEnterEmail() async {
    setStatus(Status.loading);

    bool hasConnection = await _hasConnection;
    if (!hasConnection) {
      setFailureText("Verifique sua conexão e tente novamente.");
      return;
    }

    var loginWithEmail = await loginWithEmailUsecase(credential);
    loginWithEmail.fold(
      (failure) => setFailureText(failure.message),
      (user) async => await saveUserData(user),
    );
  }

  void onEnterGoogle() {
    requestEnterGoogle();
  }

  Future<void> requestEnterGoogle() async {
    bool hasConnection = await _hasConnection;
    if (!hasConnection) {
      setFailureText("Verifique sua conexão e tente novamente.");
      return;
    }

    var result = await loginWithGoogleUsecase();

    result.fold(
      (failure) => setFailureText(failure.message),
      (user) => saveUserData(user),
    );
  }

  Future<void> saveUserData(UserEntity user) async {
    var result = await createUserDataUsecase(user: user);

    result.fold(
      (failure) => setFailureText(failure.message),
      (savedUser) {
        authStore.setUser(savedUser);
        Modular.to.pushNamedAndRemoveUntil("/home", (p0) => false);
      },
    );
  }
}
