import 'package:fit_training_clean/app/core/components/custom_elevated_button.dart';
import 'package:fit_training_clean/app/core/components/custom_textfield.dart';
import 'package:fit_training_clean/app/core/components/show_error.dart';
import 'package:fit_training_clean/app/core/components/show_loading.dart';
import 'package:fit_training_clean/app/core/utils/status.dart';
import 'package:fit_training_clean/app/modules/login/presenter/pages/recover_password/recover_password_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  RecoverPasswordStore store = Modular.get<RecoverPasswordStore>();

  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController(text: store.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recuperar senha"),
        centerTitle: true,
      ),
      body: Observer(
        builder: (context) {
          if (store.status == Status.loading) {
            return const ShowLoading();
          }
          if (store.status == Status.failure) {
            return ShowError(
              title: "Ocorreu um erro",
              content: store.failureText,
              onPressed: () => store.setStatus(Status.initial),
            );
          }
          if (store.status == Status.success) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight!,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      "E-mail enviado com sucesso!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Image.asset(
                            "assets/images/logo.png",
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Um e-mail foi enviado para \"${store.email}\". Confira em sua caixa de e-mails os passos para gerar uma nova senha.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    CustomElevatedButton.outlined(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      label: "Ok",
                      onPressed: () {
                        Modular.to.pop();
                        store.setStatus(Status.initial);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight!,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        "Digite seu e-mail abaixo para recuperar sua senha.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Você receberá um e-mail com os passos para gerar uma nova senha.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Form(
                        key: store.key,
                        child: CustomTextfield(
                          padding: const EdgeInsets.only(top: 20),
                          controller: emailController,
                          labelText: "E-mail",
                          onChanged: store.setEmail,
                          hintText: "example@gmail.com",
                          validator: store.validatorEmail,
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    label: "Enviar",
                    onPressed: store.onRecoverPassord,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
