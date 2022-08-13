abstract class FailureAuth implements Exception {
  String get message;
}

class ErrorGetLoggedUser implements FailureAuth {
  @override
  String message;
  ErrorGetLoggedUser({this.message = ""});
}

class ErrorLogout implements FailureAuth {
  @override
  String message;
  ErrorLogout({this.message = ""});
}
