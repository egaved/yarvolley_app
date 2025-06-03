import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  // final String baseUrl = 'http://10.0.2.2:3000/api';
  final String baseUrl = 'http://192.168.1.64:3000/api';

  Future<http.Response> get(String endpoint) async {
    return await http.get(Uri.parse('$baseUrl/$endpoint'));
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    return await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      body: jsonEncode(body),
    );
  }
}
