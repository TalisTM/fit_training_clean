import 'package:fit_training_clean/app/modules/auth/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<Module> get imports => [
    AuthModule()
  ];

  @override
  List<ModularRoute> get routes => [
    // ChildRoute("/", child: (_, __) => SplashPage()),
    ModuleRoute("/login", module: AuthModule()),
    // ChildRoute("/home", child: (_, __) => HomePage())
  ];
}
