import 'package:fit_training_clean/app/core/modules/connection/connection_module.dart';
import 'package:fit_training_clean/app/core/modules/create_user_data/create_user_data_module.dart';
import 'package:fit_training_clean/app/modules/register/data/repositories/register_repository_impl.dart';
import 'package:fit_training_clean/app/modules/register/domain/usecases/register_with_email_usecase.dart';
import 'package:fit_training_clean/app/modules/register/external/datasources/firebase_register_datasource_impl.dart';
import 'package:fit_training_clean/app/modules/register/presenter/pages/register/register_page.dart';
import 'package:fit_training_clean/app/modules/register/presenter/pages/register/register_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => RegisterWithEmailUsecaseImpl(repository: i(), hasConnectionUsecase: i())),
        Bind((i) => RegisterRepositoryImpl(datasource: i())),
        Bind((i) => FirebaseRegisterDatasourceImpl(auth: i())),
        Bind((i) => RegisterStore(
              authStore: i(),
              createUserDataUsecase: i(),
              registerWithEmailUsecase: i(),
            )),
      ];

  @override
  List<Module> get imports => [
        CreateUserDataModule(),
        ConnectionModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, __) => const RegisterPage()),
      ];
}
