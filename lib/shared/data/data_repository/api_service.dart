import 'api_client.dart';

class ApiService {
  final ApiClient apiClient;

  ApiService(this.apiClient);

  Future<dynamic> getData(String endpoint,
      {Map<String, String>? headers}) async {
    return await apiClient.get(
      endpoint,
      headers: headers,
    );
  }

  Future<dynamic> postData(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    return await apiClient.post(
      endpoint,
      body,
      headers: headers,
    );
  }
}
