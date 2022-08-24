import 'package:fit_training_clean/app/core/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/auth/presenter/stores/auth_store.dart';
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

  @observable
  String email = "";
  @action
  setEmail(String value) => email = value;
  String? validatorEmail(String? value) {
    if (!credential.isValidEmail) {
      return "E-mail inválido";
    }
    return null;
  }

  @observable
  String password = "";
  @action
  setPassword(String value) => password = value;
  String? validatorPassword(String? value) {
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

  Future<void> onRegisterEmail() async {
    if (!key.currentState!.validate()) return;
    setStatus(Status.loading);
    var result = await registerWithEmailUsecase(credential);
    result.fold(
      (faulure) => setFailureText(faulure.message),
      (user) async => saveUserData(user),
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
