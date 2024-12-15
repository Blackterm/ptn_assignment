import 'package:ptn_assignment/shared/data/models/login_token.dart';

import '../../shared/data/data_repository/api_service.dart';

class RegisterDataRepository {
  final ApiService apiService;

  RegisterDataRepository(this.apiService);

  Future<LoginToken> postRegister(
    String name,
    String email,
    String password,
  ) async {
    var body = {
      "name": name,
      "email": email,
      "password": password,
    };
    final data = await apiService.postData(
      'register',
      body,
    );
    return LoginToken.fromJson(data);
  }
}
