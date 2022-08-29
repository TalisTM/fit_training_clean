import 'package:fit_training_clean/app/core/components/custom_elevated_button.dart';
import 'package:fit_training_clean/app/core/components/custom_text_button.dart';
import 'package:fit_training_clean/app/core/components/custom_textfield.dart';
import 'package:fit_training_clean/app/core/components/show_error.dart';
import 'package:fit_training_clean/app/core/components/show_loading.dart';
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
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset(
                      "assets/images/logo.png",
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
                      padding: const EdgeInsets.only(top: 20),
                      labelText: "Senha",
                      hintText: "********",
                      obscureText: store.hidePassword,
                      onChanged: store.setPassword,
                      validator: store.validatorPassword,
                      suffixIcon: store.hidePassword ? Icons.visibility : Icons.visibility_off,
                      suffixPressed: () => store.setHidePassowrd(!store.hidePassword),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(
                    label: "Esqueceu a senha?",
                    onPressed: () => Modular.to.pushNamed("/login/recover-password"),
                  ),
                ],
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomElevatedButton(
                            label: "Login",
                            margin: const EdgeInsets.only(bottom: 15),
                            onPressed: store.onEnterEmail,
                          ),
                          CustomElevatedButton.outlined(
                            label: "Cadastrar-se",
                            onPressed: () => Modular.to.pushNamed("/register"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    AspectRatio(
                      aspectRatio: 1,
                      child: TextButton(
                        onPressed: store.onEnterGoogle,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/images/logo_google.png",
                            height: 50,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            (const Color(0xFF2c2c2c)),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40)
            ],
          ),
        );
      }),
    );
  }
}
