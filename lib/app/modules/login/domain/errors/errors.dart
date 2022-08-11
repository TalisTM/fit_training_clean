abstract class FailureLogin implements Exception {
  String get message;
}

class ErrorLoginEmail implements FailureLogin {
  @override
  String message;
  ErrorLoginEmail({this.message = ""});
}

class ErrorLoginGoogle implements FailureLogin {
  @override
  String message;
  ErrorLoginGoogle({this.message = ""});
}
