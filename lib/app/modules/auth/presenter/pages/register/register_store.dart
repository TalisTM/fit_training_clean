import 'package:fit_training_clean/app/core/stores/auth_store.dart';
import 'package:fit_training_clean/app/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/register_with_email_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;
part 'register_store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;

abstract class _RegisterStoreBase with Store {
  final RegisterWithEmailUsecase registerWithEmailUsecase;
  final AuthStore authStore;

  _RegisterStoreBase({
    required this.registerWithEmailUsecase,
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

  registerEmail() async {
    // loading on
    var result = await registerWithEmailUsecase(credential);
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