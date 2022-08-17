import 'package:fit_training_clean/app/core/utils/status.dart';
import 'package:fit_training_clean/app/modules/home/presenter/pages/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore store = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
        centerTitle: true,
      ),
      body: Observer(
        builder: (context) {
          if (store.status == Status.initial) {
            return Column(
              children: [
                TextButton(
                  onPressed: store.onLogout,
                  child: const Text("deslogar"),
                )
              ],
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
