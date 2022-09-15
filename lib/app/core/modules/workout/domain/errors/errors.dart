abstract class FailureWorkout implements Exception {
  String get message;
}

class ErrorUpdateWorkout implements FailureWorkout {
  @override
  String message;
  ErrorUpdateWorkout({this.message = ""});
}
