import 'package:asuka/asuka.dart' as asuka;
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/login_credentials.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/auth/presenter/stores/auth_store.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/domain/usecases/create_user_data_usecase.dart';
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

  Future<void> onRegisterEmail() async {
    // loading on
    var result = await registerWithEmailUsecase(credential);
    //loading off
    result.fold(
      (faulure) => _showError(faulure),
      (user) async => saveUserData(user),
    );
  }

  Future<void> saveUserData(UserEntity user) async {
    print("testeee");
    var result = await createUserDataUsecase(user: user);

    result.fold(
      (failure) => _showError(failure),
      (savedUser) {
        authStore.setUser(savedUser);
        Modular.to.popUntil(ModalRoute.withName(Modular.initialRoute));
        Modular.to.pop();
      },
    );
  }
}
