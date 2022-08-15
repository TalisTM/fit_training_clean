import 'package:fit_training_clean/app/core/utils/status.dart';
import 'package:fit_training_clean/app/modules/register/presenter/pages/register/register_store.dart';
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
      body: Observer(
        builder: (context) {
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
                  onPressed: store.isValid ? store.onRegisterEmail : null,
                  child: const Text("Cadastrar"),
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
        },
      ),
    );
  }
}
