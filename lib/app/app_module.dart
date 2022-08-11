import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/core/auth/presenter/pages/splash_page.dart';
import 'package:fit_training_clean/app/core/auth/presenter/stores/auth_store.dart';
import 'package:fit_training_clean/app/core/create_user_data/data/repositories/create_user_data_repository_impl.dart';
import 'package:fit_training_clean/app/core/create_user_data/domain/usecases/create_user_data_usecase.dart';
import 'package:fit_training_clean/app/core/create_user_data/external/datasources/firebase_firestore_datasource_impl.dart';
import 'package:fit_training_clean/app/core/register/domain/usecases/register_with_email_usecase.dart';
import 'package:fit_training_clean/app/modules/login/presenter/pages/login/login_page.dart';
import 'package:fit_training_clean/app/modules/login/presenter/pages/login/login_store.dart';
import 'package:fit_training_clean/app/modules/login/presenter/pages/register/register_page.dart';
import 'package:fit_training_clean/app/modules/login/presenter/pages/register/register_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'modules/login/data/repositories/login_repository_impl.dart';
import 'core/auth/domain/usecases/get_logged_user_usecase.dart';
import 'modules/login/domain/usecases/login_with_email_usecase.dart';
import 'modules/login/domain/usecases/login_with_google_usecase.dart';
import 'core/auth/domain/usecases/logout_usecase.dart';
import 'modules/login/external/datasources/firebase_login_datasource_impl.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        //CORE
        Bind((i) => FirebaseAuth.instance),

        //CORE CREATE_USER_DATA
        Bind((i) => FirebaseFirestore.instance),

        Bind((i) => CreateUserDataUsecaseImpl(repository: i())),

        Bind((i) => CreateUserDataRepositoryImpl(datasouce: i())),
        Bind((i) => FirebaseFirestoreDatasourceImpl(firestore: i())),

        //CORE AUTH
        Bind((i) => GetLoggedUserUsecaseImpl(repository: i())),
        Bind((i) => LogoutUsecaseImpl(repository: i())),

        ///[Auth Repository com os dois usecase acima]

        Bind((i) => AuthStore(getLoggedUserUsecase: i(), logoutUsecase: i())),

        //REGISTER
        Bind((i) => RegisterWithEmailUsecaseImpl(repository: i())),

        ///[Register Repository com o usecase acima]

        Bind((i) => RegisterStore(
              authStore: i(),
              registerWithEmailUsecase: i(),
            )),

        //LOGIN
        Bind((i) => GoogleSignIn()),

        Bind((i) => LoginWithEmailUsecaseImpl(repository: i())),
        Bind((i) => LoginWithGoogleUsecaseImpl(repository: i())),

        Bind((i) => LoginRepositoryImpl(datasource: i())),
        Bind((i) => FirebaseLoginDatasourceImpl(auth: i(), googleSignIn: i())),

        Bind((i) => LoginStore(
              loginWithEmailUsecase: i(),
              loginWithGoogleUsecase: i(),
              createUserDataUsecase: i(),
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
        ChildRoute("/register", child: (_, __) => const RegisterPage()),
        // ChildRoute("/home", child: (_, __) => HomePage())
      ];
}
