abstract class FailureRegister implements Exception {
  String get message;
}

class ErrorRegisterEmail implements FailureRegister {
  @override
  String message;
  ErrorRegisterEmail({this.message = ""});
}