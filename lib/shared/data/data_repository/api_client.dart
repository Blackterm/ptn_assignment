import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/constants.dart';

class ApiClient {
  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final uri = Uri.parse('${AppENV.baseUrl}$endpoint');

    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('GET API: ${response.statusCode}');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    final response = await http.post(
      Uri.parse('${AppENV.baseUrl}$endpoint'),
      headers: headers ?? {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('POST API: ${response.statusCode}');
    }
  }
}
