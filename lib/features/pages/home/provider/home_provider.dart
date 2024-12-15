import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptn_assignment/features/data/home_data_repository.dart';
import 'package:ptn_assignment/features/data/register_data_repository.dart';
import 'package:ptn_assignment/shared/data/models/books.dart';
import 'package:ptn_assignment/shared/data/models/categories.dart';
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

final homeProvider = Provider((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return HomeDataRepository(apiService);
});

final categoryProvider = FutureProvider<Categories>((ref) async {
  final repository = ref.watch(homeProvider);
  return await repository.getCategory();
});

final bookProvider =
    FutureProvider.family<Books, Map<String, String>>((ref, credentials) async {
  final repository = ref.watch(homeProvider);
  return await repository.getProduct(
    credentials['id']!,
  );
});
