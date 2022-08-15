import 'package:fit_training_clean/app/core/utils/status.dart';
import 'package:fit_training_clean/app/modules/login/presenter/pages/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginStore store = Modular.get<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Observer(builder: (context) {
        if (store.status == Status.initial) {
          return Column(
            children: [
              const Center(child: Icon(Icons.heart_broken, size: 30)),
              TextField(
                onChanged: store.setEmail,
              ),
              TextField(
                onChanged: store.setPassword,
              ),
              TextButton(
                onPressed: store.isValid ? store.onEnterEmail : null,
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () => Modular.to.pushNamed("/register"),
                child: const Text("Novo? se cadastrar"),
              ),
              TextButton(
                onPressed: store.enterGoogle,
                child: const Text("Google"),
              )
            ],
          );
        } else if (store.status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (store.status == Status.failure) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Ocorreu um erro"),
              Text(store.failureText!),
              TextButton(
                child: const Text("Ok"),
                onPressed: () => store.setStatus(Status.initial),
              )
            ],
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
