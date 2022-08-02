import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/core/pages/splash_page.dart';
import 'package:fit_training_clean/app/core/stores/auth_store.dart';
import 'package:fit_training_clean/app/modules/auth/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => AuthStore(getLoggedUserUsecase: i(), logoutUsecase: i())),
        Bind((i) => FirebaseAuth.instance),
      ];

  @override
  List<Module> get imports => [
        AuthModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, __) => SplashPage()),
        ModuleRoute("/login", module: AuthModule()),
        // ChildRoute("/home", child: (_, __) => HomePage())
      ];
}
