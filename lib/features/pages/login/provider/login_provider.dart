import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptn_assignment/shared/data/models/login_token.dart';

import '../../../../shared/data/data_repository/api_client.dart';
import '../../../../shared/data/data_repository/api_service.dart';
import '../../../data/login_data_repository.dart';

final apiClientProvider = Provider((ref) {
  return ApiClient();
});

final apiServiceProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ApiService(apiClient);
});

final postRepositoryProvider = Provider((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return LoginDataRepository(apiService);
});

final loginProvider = FutureProvider.family<LoginToken, Map<String, String>>(
    (ref, credentials) async {
  final repository = ref.watch(postRepositoryProvider);
  return await repository.postLogin(
      credentials['email']!, credentials['password']!);
});
