import 'package:fit_training_clean/app/core/modules/auth/domain/usecases/get_logged_user_usecase.dart';
import 'package:fit_training_clean/app/core/modules/auth/presenter/stores/auth_store.dart';
import 'package:mobx/mobx.dart';
part 'splash_store.g.dart';

class SplashStore = _SplashStoreBase with _$SplashStore;

abstract class _SplashStoreBase with Store {
  final GetLoggedUserUsecase getLoggedUserUsecase;
  final AuthStore authStore;

  _SplashStoreBase({required this.getLoggedUserUsecase, required this.authStore});

  checkLogin() async {
    var result = await getLoggedUserUsecase();

    return result.fold(
      (l) => null,
      (user) {
        authStore.setUser(user);
      },
    );
  }
}
