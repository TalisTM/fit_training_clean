abstract class FailureUser implements Exception {}

class ConnectionError implements FailureUser {
  String? message;
  ConnectionError({this.message});
}

class ErrorLoginEmail implements FailureUser {
  String? message;
  ErrorLoginEmail({this.message});
}

class ErrorLoginGoogle implements FailureUser {
  String? message;
  ErrorLoginGoogle({this.message});
}

class ErrorGetLoggedUser implements FailureUser {
  String? message;
  ErrorGetLoggedUser({this.message});
}

class ErrorLogout implements FailureUser {
  String? message;
  ErrorLogout({this.message});
}