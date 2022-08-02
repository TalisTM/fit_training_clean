import 'package:fit_training_clean/app/core/stores/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key) {
    AuthStore store = Modular.get<AuthStore>();
    print("aaaaaaaaaaaa");
    store.checkLogin().then((v) async {
      print(store.isLogged);
      return await Future.delayed(const Duration(seconds: 1));
    }).then((value) {
      print(store.isLogged);
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
