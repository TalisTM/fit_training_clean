abstract class FailureUser implements Exception {}

class ErrorLoginEmail implements FailureUser {
  String? message;
  ErrorLoginEmail({this.message});
}

class ConnectionError implements FailureUser {
  String? message;
  ConnectionError({this.message});
}