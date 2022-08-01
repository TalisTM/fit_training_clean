import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_training_clean/app/modules/auth/data/repositories/login_repository_impl.dart';
import 'package:fit_training_clean/app/modules/auth/data/services/connectivity_service_impl.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/get_logged_user_usecase.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:fit_training_clean/app/modules/auth/domain/usecases/logout_usecase.dart';
import 'package:fit_training_clean/app/modules/auth/external/datasources/firebase_datasource_impl.dart';
import 'package:fit_training_clean/app/modules/auth/external/drivers/flutter_connectivity_driver_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
    Bind((i) => FirebaseAuth.instance),
    Bind((i) => LoginWithEmailUsecaseImpl(repository: i(), service: i())),
    Bind((i) => LoginWithGoogleImpl(repository: i(), service: i())),
    Bind((i) => GetLoggedUserUsecaseImpl(repository: i())),
    Bind((i) => LogoutUsecaseImpl(repository: i())),
    Bind((i) => LoginRepositoryImpl(datasource: i())),
    Bind((i) => FirebaseDatasourceImpl(auth: i())),
    Bind((i) => ConnectivityServiceImpl(driver: i())),
    Bind((i) => FlutterConnectivityDriver(connectivity: i()))
  ];

  @override
  List<ModularRoute> get routes => [
    // ChildRoute("/", child: (_, __) => LoginPage()),
  ];
}
