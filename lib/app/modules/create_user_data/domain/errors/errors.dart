abstract class FailureCreateUser {
  String get message;
}

class ErrorCheckUserExists implements FailureCreateUser {
  @override
  String message;
  ErrorCheckUserExists({this.message = ""});
}
