import 'package:fit_training_clean/app/core/components/custom_elevated_button.dart';
import 'package:fit_training_clean/app/core/components/custom_textfield.dart';
import 'package:fit_training_clean/app/core/utils/status.dart';
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
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Observer(builder: (context) {
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
      }),
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
                  onChanged: store.setEmail,
                  hintText: "example@gmail.com",
                  validator: store.validatorEmail,
                ),
                CustomTextfield(
                  controller: passwordController,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  labelText: "Senha",
                  hintText: "********",
                  obscureText: true,
                  onChanged: store.setPassword,
                  validator: store.validatorPassword,
                ),
              ],
            ),
          ),
          CustomElevatedButton(
            label: "Login",
            onPressed: store.onEnterEmail,
          ),
          TextButton(
            onPressed: () => Modular.to.pushNamed("/register"),
            child: Text(
              "Novo? cadastrar-se",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: store.enterGoogle,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/images/logo_google.png",
                        height: 25,
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 40,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Continuar com Google",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    (const Color(0xFF2c2c2c)),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  // shape: MaterialStateProperty.all<OutlinedBorder>(
                  //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  // ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40)
        ],
      ),
    );
  }
}
