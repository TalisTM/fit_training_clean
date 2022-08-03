import 'package:fit_training_clean/app/modules/auth/presenter/pages/login/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  // @override
  // List<Bind<Object>> get binds => [
  //   Bind((i) => LoginWithEmailUsecaseImpl(repository: i(), service: i()), export: true),
  //   Bind((i) => LoginWithGoogleUsecaseImpl(repository: i(), service: i()), export: true),
  //   Bind((i) => GetLoggedUserUsecaseImpl(repository: i()), export: true),
  //   Bind((i) => LogoutUsecaseImpl(repository: i()), export: true),
  //   Bind((i) => LoginRepositoryImpl(datasource: i())),
  //   Bind((i) => FirebaseDatasourceImpl(auth: i())),
  //   Bind((i) => ConnectivityServiceImpl(driver: i())),
  //   Bind((i) => FlutterConnectivityDriver(connectivity: i())),
  // ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, __) => const LoginPage()),
      ];
}
