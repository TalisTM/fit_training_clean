import 'package:fit_training_clean/app/core/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/auth/presenter/stores/auth_store.dart';
import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/domain/usecases/create_user_data_usecase.dart';
import 'package:fit_training_clean/app/core/utils/status.dart';
import 'package:fit_training_clean/app/modules/register/domain/usecases/register_with_email_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;

abstract class _RegisterStoreBase with Store {
  final RegisterWithEmailUsecase registerWithEmailUsecase;
  final CreateUserDataUsecase createUserDataUsecase;
  final AuthStore authStore;

  _RegisterStoreBase({
    required this.registerWithEmailUsecase,
    required this.createUserDataUsecase,
    required this.authStore,
  });

  final key = GlobalKey<FormState>();

  // NAME
  @observable
  String name = "";
  @action
  void setName(String value) => name = value;
  String? validatorName(String? value) {
    if (name.isEmpty) {
      return "Nome inválido";
    }
    return null;
  }

  // EMAIL
  @observable
  String email = "";
  @action
  void setEmail(String value) => email = value;
  String? validatorEmail(String? value) {
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
  String? validatorPassword(String? value) {
    if (!credential.isValidPassword) {
      return "Senha inválida";
    }
    return null;
  }

  // CONFPASSWORD
  @observable
  String confPassword = "";
  @action
  void setConfPassword(String value) => confPassword = value;
  String? validatorConfPassword(String? value) {
    if (confPassword.length <= 5) {
      return "Senha inválida";
    }

    if (confPassword != password) {
      return "Senhas não coincidem";
    }
    return null;
  }

  //HIDE PASSWORD
  @observable
  bool hidePassword = true;
  @action
  void setHidePassowrd(bool value) => hidePassword = value;

  // STATUS
  @observable
  Status status = Status.initial;
  @action
  void setStatus(Status value) => status = value;

  // FAILURE TEXT
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

  void onRegisterEmail() {
    if (!key.currentState!.validate()) return;
    requestRegisterEmail();
  }

  Future<void> requestRegisterEmail() async {
    setStatus(Status.loading);

    var result = await registerWithEmailUsecase(credential);
    result.fold(
      (faulure) => setFailureText(faulure.message),
      (resultUser) async {
        UserEntity user = UserEntity(
          uid: resultUser.uid,
          name: name,
          email: resultUser.email,
          photoUrl: resultUser.photoUrl,
          amountDone: resultUser.amountDone,
          restTimeInSeconds: resultUser.restTimeInSeconds,
          workouts: resultUser.workouts,
        );
        saveUserData(user);
      },
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
