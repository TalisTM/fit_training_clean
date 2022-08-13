import 'package:fit_training_clean/app/core/auth/presenter/stores/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthStore store = Modular.get<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              store.logout();
              Modular.to.popUntil(ModalRoute.withName(Modular.initialRoute));
              Modular.to.pop();
            },
            child: const Text("deslogar"),
          )
        ],
      ),
    );
  }
}
