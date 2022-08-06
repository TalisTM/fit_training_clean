import 'package:fit_training_clean/app/core/presenter/stores/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key) {
    AuthStore store = Modular.get<AuthStore>();
    store.checkLogin().then((v) async {
      return await Future.delayed(const Duration(seconds: 1));
    }).then((value) {
      if (store.isLogged) {
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
