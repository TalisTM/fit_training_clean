import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/core/modules/auth/auth_module.dart';
import 'package:fit_training_clean/app/core/modules/splash/splash_module.dart';
import 'package:fit_training_clean/app/modules/crud_workout/crud_workout_module.dart';
import 'package:fit_training_clean/app/modules/home/home_module.dart';
import 'package:fit_training_clean/app/modules/login/login_module.dart';
import 'package:fit_training_clean/app/modules/register/register_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => FirebaseAuth.instance),
        Bind((i) => FirebaseFirestore.instance),
      ];

  @override
  List<Module> get imports => [
        AuthModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute("/", module: SplashModule()),
        ModuleRoute("/home", module: HomeModule()),
        ModuleRoute("/login", module: LoginModule()),
        ModuleRoute("/register", module: RegisterModule()),
        ModuleRoute("/crud-workout", module: CrudWorkoutmodule()),
      ];
}
