import 'package:string_validator/string_validator.dart' as validator;

class LoginCredentials {
  final String? email;
  final String? password;
  final String? idToken;
  final String? accessToken;

  LoginCredentials._({this.email, this.password, this.idToken, this.accessToken});

  bool get isValidEmail => validator.isEmail(email ?? "");

  bool get isValidPassword => password != null && password!.isNotEmpty && password!.length > 3;

  bool get isvalidIdToken => idToken != null && idToken!.isNotEmpty;

  bool get isvalidAccessToken => accessToken != null && accessToken!.isNotEmpty;

  factory LoginCredentials.withEmailAndPassword({required String email, required String password}) {
    return LoginCredentials._(
      email: email,
      password: password
    );
  }

  factory LoginCredentials.withGoogle({required String idToken, required String accessToken}) {
    return LoginCredentials._(
      idToken: idToken,
      accessToken: accessToken
    );
  }
}