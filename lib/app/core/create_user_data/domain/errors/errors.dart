abstract class FailureCreateUser {
  String get message;
}

class ErrorCreateUserData implements FailureCreateUser {
  @override
  String message;
  ErrorCreateUserData({this.message = ""});
}
