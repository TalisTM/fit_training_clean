import 'package:fit_training_clean/app/core/modules/auth/domain/usecases/logout_usecase.dart';
import 'package:fit_training_clean/app/core/modules/auth/presenter/stores/auth_store.dart';
import 'package:fit_training_clean/app/core/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final LogoutUsecase logoutUsecase;
  final AuthStore authStore;
  _HomeStoreBase({required this.logoutUsecase, required this.authStore});

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

  Future<void> onLogout() async {
    var result = await logoutUsecase();

    result.fold(
      (failure) => setFailureText(failure.message),
      (r) {
        authStore.setUser(null);
        Modular.to.popUntil(ModalRoute.withName(Modular.initialRoute));
        Modular.to.pop();
      },
    );
  }
}
