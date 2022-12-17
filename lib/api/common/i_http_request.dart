// ignore_for_file: constant_identifier_names

enum HttpMethod { GET, POST }

class IHttpRequest {
  String? absolutePath;
  HttpMethod? httpMethod;
  Map<String, String>? _headers;
  Map<String, String>? _parameters;
  Object? body;

  static Map<String, String>? defaultHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ',
  };

  Map<String, dynamic>? get headers {
    return _headers!;
  }

  Map<String, String>? get parameters {
    return _parameters!;
  }
}
