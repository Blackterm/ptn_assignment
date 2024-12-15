import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptn_assignment/features/data/register_data_repository.dart';
import 'package:ptn_assignment/shared/data/models/login_token.dart';
import '../../../../shared/data/data_repository/api_client.dart';
import '../../../../shared/data/data_repository/api_service.dart';

final apiClientProvider = Provider((ref) {
  return ApiClient();
});

final apiServiceProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ApiService(apiClient);
});

final postRegisterProvider = Provider((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return RegisterDataRepository(apiService);
});

final registerProvider = FutureProvider.family<LoginToken, Map<String, String>>(
    (ref, credentials) async {
  final repository = ref.watch(postRegisterProvider);
  return await repository.postRegister(
    credentials['email']!,
    credentials['email']!,
    credentials['password']!,
  );
});
