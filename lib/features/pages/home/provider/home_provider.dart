import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptn_assignment/features/data/home_data_repository.dart';
import 'package:ptn_assignment/shared/data/models/books.dart';
import 'package:ptn_assignment/shared/data/models/categories.dart';
import 'package:ptn_assignment/shared/data/models/cover_image.dart';
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

final bookProvider = FutureProvider.family<Books, String>((ref, id) async {
  final repository = ref.watch(homeProvider);
  final response = await repository.getProduct(id);

  return response;
});

final imageProvider =
    FutureProvider.family<CoverImage, String>((ref, fileName) async {
  final repository = ref.watch(homeProvider);
  final response = await repository.postCoverImage('$fileName.png');
  return response;
});

final selectedCategoryIdProvider = StateProvider<int>((ref) => 0);
final searchQueryProvider = StateProvider<String>((ref) => '');
