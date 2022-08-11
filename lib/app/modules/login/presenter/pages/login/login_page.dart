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
      body: Column(
        children: [
          const Center(child: Icon(Icons.heart_broken, size: 30)),
          TextField(
            onChanged: store.setEmail,
          ),
          TextField(
            onChanged: store.setPassword,
          ),
          Observer(builder: (context) {
            return TextButton(
                onPressed: store.isValid ? store.enterEmail : null, child: const Text("Login"));
          }),
          TextButton(
            onPressed: () => Modular.to.pushNamed("/register"),
            child: const Text("Novo? se cadastrar"),
          ),
          TextButton(
            onPressed: store.enterGoogle,
            child: const Text("Google"),
          )
        ],
      ),
    );
  }
}
