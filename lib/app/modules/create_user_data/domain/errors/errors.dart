abstract class FailureCreateUser {
  String get message;
}

class ErrorCheckUserExists implements FailureCreateUser {
  @override
  String message;
  ErrorCheckUserExists({this.message = ""});
}

class ErrorSaveNewUser implements FailureCreateUser {
  @override
  String message;
  ErrorSaveNewUser({this.message = ""});
}

class ErrorFetchExistingUser implements FailureCreateUser {
  @override
  String message;
  ErrorFetchExistingUser({this.message = ""});
}
