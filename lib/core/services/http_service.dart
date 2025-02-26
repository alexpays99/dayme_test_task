import 'package:http/http.dart' as http;

class HttpService {
  final http.Client _client;

  HttpService({http.Client? client}) : _client = client ?? http.Client();

  Future<http.Response> get(String url) => _client.get(Uri.parse(url));

  Future<http.Response> post(String url, {Map<String, dynamic>? body}) async {
    return _client.post(
      Uri.parse(url),
      body: body,
      headers: {'Content-Type': 'application/json'},
    );
  }
}
