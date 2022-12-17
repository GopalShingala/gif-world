class HttpException implements Exception {
  String message;
  HttpException(this.message);
}

class NetworkException implements Exception {
  String message;
  NetworkException(this.message);
}

class TokenExpiredException implements Exception {
  String message;
  TokenExpiredException(this.message);
}

class EmailAlreadyRegisterdException implements Exception {
  String message;
  EmailAlreadyRegisterdException(this.message);
}

class InavalidEmailorPasswordException implements Exception {
  String message;
  InavalidEmailorPasswordException(this.message);
}
