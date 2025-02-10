abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  final int? statusCode;
  ServerFailure({required super.errorMessage, this.statusCode});
}

class ValidationFailure<T> extends ServerFailure {
  final String fieldError;

  ValidationFailure({
    required super.errorMessage,
    required super.statusCode,
    required this.fieldError,
  });
}
