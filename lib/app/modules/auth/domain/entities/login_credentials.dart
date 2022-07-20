import 'package:string_validator/string_validator.dart' as validator;

class LoginCredentials {
  final String? email;
  final String? password;

  LoginCredentials._({this.email, this.password});

  bool get isValidEmail => validator.isEmail(email ?? "");

  bool get isValidPassword => password != null && password!.isNotEmpty && password!.length > 3;

  factory LoginCredentials.withEmailAndPassword({required String email, required String password}) {
    return LoginCredentials._(
      email: email,
      password: password
    );
  }
}