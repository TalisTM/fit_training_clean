import 'package:fit_training_clean/app/modules/home/presenter/pages/home_store.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          TextButton(
            onPressed: store.onLogout,
            child: const Text("deslogar"),
          )
        ],
      ),
    );
  }
}
