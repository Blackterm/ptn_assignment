import 'package:ptn_assignment/shared/data/models/login_token.dart';

import '../../shared/data/data_repository/api_service.dart';

class LoginDataRepository {
  final ApiService apiService;

  LoginDataRepository(this.apiService);

  Future<LoginToken> postLogin(String email, String password) async {
    var body = {
      "email": email,
      "password": password,
    };
    final data = await apiService.postData(
      'login',
      body,
    );
    return LoginToken.fromJson(data);
  }
}
