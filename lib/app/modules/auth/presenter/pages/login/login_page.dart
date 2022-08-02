import 'package:fit_training_clean/app/modules/auth/presenter/pages/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginStore store = Modular.get<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Icon(Icons.heart_broken, size: 30),
            TextField(
              onChanged: store.setEmail,
            ),
            TextField(
              onChanged: store.setPassword,
            ),
            TextButton(
              onPressed: store.isValid ? store.enterEmail : null,
              child: Text(
                "Login"
              )
            ),
            TextButton(
              onPressed: store.enterGoogle,
              child: Text(
                "Google"
              )
            )
          ],
        ));
  }
}
