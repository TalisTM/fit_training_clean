import 'package:fit_training_clean/app/core/modules/connection/domain/usecases/has_connection_usecase.dart';
import 'package:fit_training_clean/app/core/utils/status.dart';
import 'package:fit_training_clean/app/core/utils/utils.dart';
import 'package:fit_training_clean/app/modules/login/domain/usecases/recover_password_usecase.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:string_validator/string_validator.dart' as validator;

part 'recover_password_store.g.dart';

class RecoverPasswordStore = _RecoverPasswordStoreBase with _$RecoverPasswordStore;

abstract class _RecoverPasswordStoreBase with Store {
  final HasConnectionUsecase hasConnectionUsecase;
  final RecoverPasswordUsecase recoverPasswordUsecase;

  _RecoverPasswordStoreBase({
    required this.hasConnectionUsecase,
    required this.recoverPasswordUsecase,
  });

  final key = GlobalKey<FormState>();

  // EMAIL
  @observable
  String email = "";

  @action
  void setEmail(String value) => email = value;

  String? validatorEmail(String? value) {
    if (!validator.isEmail(value ?? "")) {
      return "E-mail inválido";
    }
    return null;
  }

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

  void onRecoverPassord() {
    if (!key.currentState!.validate()) return;
    requestRecoverPassword();
  }

  Future<void> requestRecoverPassword() async {
    setStatus(Status.loading);

    bool hasConnection = await Utils.connection.hasConnection(hasConnectionUsecase);
    if (!hasConnection) {
      setFailureText("Verifique sua conexão e tente novamente");
      return;
    }

    var result = await recoverPasswordUsecase(email: email);

    result.fold(
      (failure) => setFailureText(failure.message),
      (_) => {setStatus(Status.success)},
    );
  }
}
