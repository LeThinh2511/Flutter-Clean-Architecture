import 'package:http/http.dart' as http;

abstract class NetworkClient {

}

// class NetworkClient extends http.BaseClient {
//   final String userAgent;
//   final http.Client _inner;
//
//   NetworkClient(this.userAgent, this._inner);
//
//   Future<http.StreamedResponse> send(http.BaseRequest request) {
//     http.BaseClient
//     request.headers['user-agent'] = userAgent;
//     return _inner.send(request);
//   }
// }