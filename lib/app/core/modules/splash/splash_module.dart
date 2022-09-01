import 'package:fit_training_clean/app/core/modules/create_user_data/create_user_data_module.dart';
import 'package:fit_training_clean/app/core/modules/splash/presenter/pages/splash/splash_page.dart';
import 'package:fit_training_clean/app/core/modules/splash/presenter/pages/splash/splash_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => SplashStore(
              authStore: i(),
              createUserDataUsecase: i(),
              getLoggedUserUsecase: i(),
            )),
      ];

  @override
  List<Module> get imports => [
        CreateUserDataModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, __) => const SplashPage()),
      ];
}
