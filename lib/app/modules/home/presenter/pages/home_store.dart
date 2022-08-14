import 'package:fit_training_clean/app/core/modules/auth/presenter/stores/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final AuthStore authStore;
  _HomeStoreBase({required this.authStore});

  Future<void> onLogout() async {
    authStore.logout();
    Modular.to.popUntil(ModalRoute.withName(Modular.initialRoute));
    Modular.to.pop();
  }
}
