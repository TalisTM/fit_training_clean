import 'package:fit_training_clean/app/core/components/custom_elevated_button.dart';
import 'package:fit_training_clean/app/core/components/custom_textfield.dart';
import 'package:fit_training_clean/app/core/components/show_error.dart';
import 'package:fit_training_clean/app/core/components/show_loading.dart';
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

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confPasswordController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: store.name);
    emailController = TextEditingController(text: store.email);
    passwordController = TextEditingController(text: store.password);
    confPasswordController = TextEditingController(text: store.confPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar"),
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
              content: store.failureText!,
              onPressed: () => store.setStatus(Status.initial),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 40),
                      child: Image.asset(
                        "assets/images/logo.png",
                        color: Theme.of(context).primaryColor,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  ],
                ),
                Form(
                  key: store.key,
                  child: Column(
                    children: [
                      CustomTextfield(
                        controller: nameController,
                        labelText: "Nome",
                        hintText: "João da Silva",
                        onChanged: store.setName,
                        validator: store.validatorName,
                      ),
                      CustomTextfield(
                        padding: const EdgeInsets.only(top: 15),
                        controller: emailController,
                        labelText: "E-mail",
                        hintText: "example@gmail.com",
                        onChanged: store.setEmail,
                        validator: store.validatorEmail,
                      ),
                      CustomTextfield(
                        controller: passwordController,
                        padding: const EdgeInsets.only(top: 15),
                        labelText: "Senha",
                        hintText: "********",
                        obscureText: store.hidePassword,
                        onChanged: store.setPassword,
                        validator: store.validatorPassword,
                        suffixIcon: store.hidePassword ? Icons.visibility : Icons.visibility_off,
                        suffixPressed: () => store.setHidePassowrd(!store.hidePassword),
                      ),
                      CustomTextfield(
                        controller: confPasswordController,
                        padding: const EdgeInsets.only(top: 15),
                        labelText: "Confirmar senha",
                        hintText: "********",
                        obscureText: store.hidePassword,
                        onChanged: store.setConfPassword,
                        validator: store.validatorConfPassword,
                        suffixIcon: store.hidePassword ? Icons.visibility : Icons.visibility_off,
                        suffixPressed: () => store.setHidePassowrd(!store.hidePassword),
                      ),
                    ],
                  ),
                ),
                CustomElevatedButton(
                  margin: const EdgeInsets.only(top: 15, bottom: 40),
                  label: "Cadastrar",
                  onPressed: store.onRegisterEmail,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
