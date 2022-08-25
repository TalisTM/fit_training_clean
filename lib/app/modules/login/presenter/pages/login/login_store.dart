import 'package:fit_training_clean/app/core/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/auth/presenter/stores/auth_store.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/domain/usecases/create_user_data_usecase.dart';
import 'package:fit_training_clean/app/core/utils/status.dart';
import 'package:fit_training_clean/app/modules/login/domain/usecases/login_with_email_usecase.dart';
import 'package:fit_training_clean/app/modules/login/domain/usecases/login_with_google_usecase.dart';
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

  @observable
  String email = "";
  @action
  setEmail(String value) => email = value;
  String? validatorEmail(String? string) {
    if (!credential.isValidEmail) {
      return "E-mail inválido";
    }
    return null;
  }

  @observable
  String password = "";
  @action
  setPassword(String value) => password = value;
  String? validatorPassword(String? string) {
    if (!credential.isValidPassword) {
      return "Senha inválida";
    }
    return null;
  }

  @observable
  bool hidePassword = true;
  @action
  setHidePassowrd(bool value) => hidePassword = value;

  @observable
  Status status = Status.initial;
  @action
  setStatus(Status value) => status = value;

  @observable
  String? failureText;
  @action
  setFailureText(String value) {
    setStatus(Status.failure);
    failureText = value;
  }

  @computed
  LoginCredentials get credential => LoginCredentials.withEmailAndPassword(
        email: email,
        password: password,
      );

  Future<bool> verifyConnection() async {
    bool hasConnection = false;
    var result = await hasConnectionUsecase();

    result.map((connection) {
      if (connection) hasConnection = true;
    });

    return hasConnection;
  }

  Future<void> onEnterEmail() async {
    if (!key.currentState!.validate()) return;
    setStatus(Status.loading);

    bool hasConnection = await verifyConnection();
    if (!hasConnection) {
      setFailureText("Verifique sua conexão e tente novamente");
      return;
    }

    var loginWithEmail = await loginWithEmailUsecase(credential);
    loginWithEmail.fold(
      (failure) => setFailureText(failure.message),
      (user) async => await saveUserData(user),
    );
  }

  Future<void> enterGoogle() async {
    await verifyConnection();

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
        Modular.to.popUntil(ModalRoute.withName(Modular.initialRoute));
        Modular.to.pop();
      },
    );
  }
}
