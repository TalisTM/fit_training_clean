import 'package:fit_training_clean/app/core/modules/splash/presenter/pages/splash/splash_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key) {
    SplashStore store = Modular.get<SplashStore>();

    store.checkLogin().then((_) async {
      return await Future.delayed(const Duration(seconds: 1));
    }).then((_) {
      if (store.authStore.isLogged) {
        Modular.to.pushNamedAndRemoveUntil("/home", (p0) => false);
      } else {
        Modular.to.pushNamedAndRemoveUntil("/login", (p0) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
