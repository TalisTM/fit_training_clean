import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/usecases/get_logged_user_usecase.dart';
import 'package:fit_training_clean/app/core/modules/auth/presenter/stores/auth_store.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/domain/usecases/create_user_data_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'splash_store.g.dart';

class SplashStore = _SplashStoreBase with _$SplashStore;

abstract class _SplashStoreBase with Store {
  final GetLoggedUserUsecase getLoggedUserUsecase;
  final CreateUserDataUsecase createUserDataUsecase;
  final AuthStore authStore;

  _SplashStoreBase({
    required this.getLoggedUserUsecase,
    required this.createUserDataUsecase,
    required this.authStore,
  });

  Future<void> checkLogin() async {
    var result = await getLoggedUserUsecase();

    return result.fold(
      (l) => Modular.to.pushNamedAndRemoveUntil("/login", (p0) => false),
      (user) => saveUserData(user),
    );
  }

  Future<void> saveUserData(UserEntity user) async {
    var result = await createUserDataUsecase(user: user);
    result.fold(
      (failure) => Modular.to.pushNamedAndRemoveUntil("/login", (p0) => false),
      (savedUser) {
        authStore.setUser(savedUser);
        Modular.to.pushNamedAndRemoveUntil("/home", (p0) => false);
      },
    );
  }
}
