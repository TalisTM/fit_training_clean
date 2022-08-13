import 'package:fit_training_clean/app/core/modules/auth/auth_module.dart';
import 'package:fit_training_clean/app/modules/home/presenter/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, __) => const HomePage()),
      ];

  @override
  List<Module> get imports => [
        AuthModule(),
      ];
}
