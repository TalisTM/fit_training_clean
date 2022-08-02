abstract class FailureUser implements Exception {
  String get message;
}

class ConnectionError implements FailureUser {
  @override
  String message;
  ConnectionError({this.message = ""});
}

class ErrorLoginEmail implements FailureUser {
  @override
  String message;
  ErrorLoginEmail({this.message = ""});
}

class ErrorLoginGoogle implements FailureUser {
  @override
  String message;
  ErrorLoginGoogle({this.message = ""});
}

class ErrorGetLoggedUser implements FailureUser {
  @override
  String message;
  ErrorGetLoggedUser({this.message = ""});
}

class ErrorLogout implements FailureUser {
  @override
  String message;
  ErrorLogout({this.message = ""});
}