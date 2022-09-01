import 'package:fit_training_clean/app/core/modules/auth/auth_module.dart';
import 'package:fit_training_clean/app/core/modules/connection/connection_module.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/create_user_data_module.dart';
import 'package:fit_training_clean/app/modules/login/data/repositories/login_repository_impl.dart';
import 'package:fit_training_clean/app/modules/login/domain/usecases/login_with_email_usecase.dart';
import 'package:fit_training_clean/app/modules/login/domain/usecases/login_with_google_usecase.dart';
import 'package:fit_training_clean/app/modules/login/domain/usecases/recover_password_usecase.dart';
import 'package:fit_training_clean/app/modules/login/external/datasources/firebase_login_datasource_impl.dart';
import 'package:fit_training_clean/app/modules/login/presenter/pages/login/login_page.dart';
import 'package:fit_training_clean/app/modules/login/presenter/pages/login/login_store.dart';
import 'package:fit_training_clean/app/modules/login/presenter/pages/recover_password/recover_password_page.dart';
import 'package:fit_training_clean/app/modules/login/presenter/pages/recover_password/recover_password_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => GoogleSignIn()),
        Bind((i) => LoginWithEmailUsecaseImpl(repository: i())),
        Bind((i) => LoginWithGoogleUsecaseImpl(repository: i())),
        Bind((i) => RecoverPasswordUsecaseImpl(repository: i())),
        Bind((i) => LoginRepositoryImpl(datasource: i())),
        Bind((i) => FirebaseLoginDatasourceImpl(auth: i(), googleSignIn: i())),
        Bind((i) => LoginStore(
              hasConnectionUsecase: i(),
              loginWithEmailUsecase: i(),
              loginWithGoogleUsecase: i(),
              createUserDataUsecase: i(),
              authStore: i(),
            )),
        Bind((i) => RecoverPasswordStore(
              hasConnectionUsecase: i(),
              recoverPasswordUsecase: i(),
            )),
      ];

  @override
  List<Module> get imports => [
        CreateUserDataModule(),
        ConnectionModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, __) => const LoginPage()),
        ChildRoute("/recover-password", child: (_, __) => const RecoverPasswordPage()),
      ];
}
