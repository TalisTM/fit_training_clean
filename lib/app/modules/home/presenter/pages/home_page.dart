import 'package:fit_training_clean/app/core/modules/auth/domain/entities/user_entity.dart';
import 'package:fit_training_clean/app/core/utils/status.dart';
import 'package:fit_training_clean/app/modules/home/presenter/pages/home_store.dart';
import 'package:fit_training_clean/app/modules/home/presenter/pages/widgets/abstract_datas_widget.dart';
import 'package:fit_training_clean/app/modules/home/presenter/pages/widgets/app_bar_home_widget.dart';
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

  late UserEntity user;

  @override
  void initState() {
    user = store.authStore.user!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHomeWidget(
        user: user,
        logout: store.onLogout,
      ),
      body: Observer(
        builder: (context) {
          if (store.status == Status.initial) {
            return Column(
              children: [
                AbstractDatasWidget(
                  amountDone: user.amountDone,
                  edit: store.onEdit,
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
