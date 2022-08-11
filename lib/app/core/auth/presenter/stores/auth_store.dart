import 'package:asuka/asuka.dart' as asuka;
import 'package:fit_training_clean/app/core/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/auth/domain/usecases/get_logged_user_usecase.dart';
import 'package:fit_training_clean/app/core/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final GetLoggedUserUsecase getLoggedUserUsecase;
  final LogoutUsecase logoutUsecase;
  _AuthStoreBase({required this.getLoggedUserUsecase, required this.logoutUsecase});

  @observable
  UserEntity? user;

  @computed
  bool get isLogged => user != null;

  @action
  void setUser(UserEntity? value) => user = value;

  Future<bool> checkLogin() async {
    var result = await getLoggedUserUsecase();

    return result.fold(
      (l) => false,
      (user) {
        setUser(user);
        return true;
      },
    );
  }

  Future<void> logout() async {
    var result = await logoutUsecase();

    result.fold(
      (l) => asuka.showSnackBar(SnackBar(content: Text(l.message))),
      (r) => setUser(null),
    );
  }
}
