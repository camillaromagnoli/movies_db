import 'package:dio/dio.dart';

class Failure implements Exception {
  final String message;
  final String? details;

  Failure(this.message, [this.details]);

  @override
  String toString() {
    if (details == null) return message;
    return '$message: $details';
  }
}

class NetworkException extends Failure {
  NetworkException([String? details]) : super("Network Error", details);
}

class ServerException extends Failure {
  ServerException([String? details]) : super("Server Error", details);
}

handleDioError<T>(DioException e) {
  if (e.type == DioExceptionType.unknown ||
      e.type == DioExceptionType.connectionTimeout) {
    return NetworkException("Failed to connect to the network");
  } else if (e.response != null) {
    return ServerException(
      "Server returned an error: ${e.response?.statusCode}",
    );
  } else {
    return Failure("Unexpected error: ${e.message}");
  }
}
