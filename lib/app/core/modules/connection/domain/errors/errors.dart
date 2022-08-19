abstract class FailureConnection implements Exception {
  String get message;
}

class ErrorConnection implements FailureConnection {
  @override
  String message;
  ErrorConnection({this.message = ""});
}
