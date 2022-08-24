import 'package:fit_training_clean/app/core/components/custom_elevated_button.dart';
import 'package:fit_training_clean/app/core/components/custom_textfield.dart';
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

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController(text: store.email);
    passwordController = TextEditingController(text: store.password);
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
          if (store.status == Status.initial) {
            return _initial();
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

  Widget _initial() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 40),
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
                  controller: emailController,
                  labelText: "E-mail",
                  hintText: "example@gmail.com",
                  onChanged: store.setEmail,
                  validator: store.validatorEmail,
                ),
                CustomTextfield(
                  controller: passwordController,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  labelText: "Senha",
                  hintText: "********",
                  obscureText: store.hidePassword,
                  onChanged: store.setPassword,
                  validator: store.validatorPassword,
                  suffixIcon: store.hidePassword ? Icons.visibility_off : Icons.visibility,
                  suffixPressed: () => store.setHidePassowrd(!store.hidePassword),
                ),
              ],
            ),
          ),
          CustomElevatedButton(
            label: "Cadastrar",
            onPressed: store.onRegisterEmail,
          ),
          const SizedBox(height: 40)
        ],
      ),
    );
  }
}
