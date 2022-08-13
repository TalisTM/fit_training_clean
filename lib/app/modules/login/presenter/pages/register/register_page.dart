import 'package:fit_training_clean/app/modules/login/presenter/pages/register/register_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterStore store = Modular.get<RegisterStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar"),
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
              onPressed: store.isValid ? store.onRegisterEmail : null,
              child: const Text("Cadastrar"),
            );
          }),
        ],
      ),
    );
  }
}
