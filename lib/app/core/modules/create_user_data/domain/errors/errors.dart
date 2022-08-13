abstract class FailureCreateUserData {
  String get message;
}

class ErrorCreateUserData implements FailureCreateUserData {
  @override
  String message;
  ErrorCreateUserData({this.message = ""});
}
