class AppException implements Exception {
  final message;
  final prefix;
  AppException([this.message, this.prefix]);

  String toString() {
    return '$prefix: $message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super(message, 'Unauthorized request');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}

class TokenExpiredException extends AppException {
  TokenExpiredException([String? message])
      : super(message, 'Authentication Failed');
}

class TokenNotFoundException extends AppException {
  TokenNotFoundException([String? message]) : super(message, 'Token Not Found');
}
