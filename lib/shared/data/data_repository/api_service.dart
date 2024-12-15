import 'api_client.dart';

class ApiService {
  final ApiClient apiClient;

  ApiService(this.apiClient);

  Future<dynamic> getData(String endpoint) async {
    return await apiClient.get(endpoint);
  }

  Future<dynamic> postData(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    return await apiClient.post(endpoint, body, headers: headers);
  }
}
