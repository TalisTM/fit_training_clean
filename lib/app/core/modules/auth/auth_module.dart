import 'package:fit_training_clean/app/core/modules/auth/data/repositories/auth_repository_impl.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/usecases/get_logged_user_usecase.dart';
import 'package:fit_training_clean/app/core/modules/auth/domain/usecases/logout_usecase.dart';
import 'package:fit_training_clean/app/core/modules/auth/external/datasources/firebase_auth_datasource_impl.dart';
import 'package:fit_training_clean/app/core/modules/auth/presenter/stores/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => GetLoggedUserUsecaseImpl(repository: i()), export: true),
        Bind((i) => LogoutUsecaseImpl(repository: i()), export: true),
        Bind((i) => AuthRepositoryImpl(datasource: i()), export: true),
        Bind((i) => FirebaseAuthDatasourceImpl(auth: i()), export: true),
        Bind((i) => AuthStore(getLoggedUserUsecase: i(), logoutUsecase: i()), export: true),
      ];
}
