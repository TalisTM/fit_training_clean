enum Status {
  initial,
  loading,
  failure,
  success,
}

extension StatusHelper on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.initial;
  bool get isFailure => this == Status.initial;
  bool get isSuccess => this == Status.initial;
}
