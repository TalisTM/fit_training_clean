import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/core/pages/splash_page.dart';
import 'package:fit_training_clean/app/core/stores/auth_store.dart';
import 'package:fit_training_clean/app/modules/auth/auth_module.dart';
import 'package:fit_training_clean/app/modules/auth/presenter/pages/login/login_page.dart';
import 'package:fit_training_clean/app/modules/auth/presenter/pages/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/auth/data/repositories/login_repository_impl.dart';
import 'modules/auth/data/services/connectivity_service_impl.dart';
import 'modules/auth/domain/usecases/get_logged_user_usecase.dart';
import 'modules/auth/domain/usecases/login_with_email_usecase.dart';
import 'modules/auth/domain/usecases/login_with_google_usecase.dart';
import 'modules/auth/domain/usecases/logout_usecase.dart';
import 'modules/auth/external/datasources/firebase_datasource_impl.dart';
import 'modules/auth/external/drivers/flutter_connectivity_driver_impl.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => FirebaseAuth.instance),
        Bind((i) => AuthStore(getLoggedUserUsecase: i(), logoutUsecase: i())),
        Bind((i) => LoginWithEmailUsecaseImpl(repository: i(), service: i())),
        Bind((i) => LoginWithGoogleUsecaseImpl(repository: i(), service: i())),
        Bind((i) => GetLoggedUserUsecaseImpl(repository: i())),
        Bind((i) => LogoutUsecaseImpl(repository: i())),
        Bind((i) => LoginRepositoryImpl(datasource: i())),
        Bind((i) => FirebaseDatasourceImpl(auth: i())),
        Bind((i) => ConnectivityServiceImpl(driver: i())),
        Bind((i) => FlutterConnectivityDriver(connectivity: i())),
        Bind((i) => Connectivity()),
        Bind((i) => LoginStore(
              loginWithEmailUsecase: i(),
              loginWithGoogleUsecase: i(),
              authStore: i(),
            )),
      ];

  // @override
  // List<Module> get imports => [
  //       AuthModule(),
  //     ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, __) => SplashPage()),
        // ModuleRoute("/login", module: AuthModule()),
        ChildRoute("/login", child: (_, __) => const LoginPage()),
        // ChildRoute("/home", child: (_, __) => HomePage())
      ];
}
