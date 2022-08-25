import 'package:fit_training_clean/app/core/modules/auth/auth_module.dart';
import 'package:fit_training_clean/app/core/modules/splash/presenter/pages/splash/splash_page.dart';
import 'package:fit_training_clean/app/core/modules/splash/presenter/pages/splash/splash_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => SplashStore(authStore: i(), getLoggedUserUsecase: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, __) => const SplashPage()),
      ];

  @override
  List<Module> get imports => [
        AuthModule(),
      ];
}
