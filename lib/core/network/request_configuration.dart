enum HTTPMethod {
  get,
  post,
  put,
  patch,
  delete,
  trace,
  options,
  connect,
  head
}

abstract class RequestConfiguration {
  late String schema;
  late String host;
  late Map<String, dynamic> headers;
  late HTTPMethod method;
  late Map<String, dynamic>? body;
  late Map<String, dynamic>? queryItems;
  late String path;
  late String? authorization;
  late int receiveTimeout;
  late int connectTimeout;
}

class DefaultRequestConfiguration extends RequestConfiguration {
  DefaultRequestConfiguration(
      {String schema = 'http',
        String host = 'numbersapi.com',
        Map<String, dynamic> headers = DefaultRequestConfiguration.defaultHeaders,
        HTTPMethod method = HTTPMethod.get,
        Map<String, dynamic>? body,
        Map<String, dynamic>? queryItems,
        String path = '',
        String? authorization,
        int receiveTimeout = Duration.microsecondsPerMinute,
        int connectTimeout = Duration.microsecondsPerMinute}) {
    this.schema = schema;
    this.host = host;
    this.headers = headers;
    this.method = method;
    this.path = path;
    this.receiveTimeout = receiveTimeout;
    this.connectTimeout = connectTimeout;
    this.body = body;
    this.queryItems = queryItems;
    this.authorization = authorization;
  }

  static const Map<String, dynamic> defaultHeaders = {
    'content-Type': 'application/json'
  };
}

extension HTTPMethodExtension on HTTPMethod {
  String get rawValue {
    return this.toString().split('.').last.toUpperCase();
  }
}