import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/data/data_repository/api_client.dart';
import '../../../../shared/data/data_repository/api_service.dart';
import '../../../../shared/data/models/books.dart';
import '../../../../shared/data/models/cover_image.dart';
import '../../../data/home_data_repository.dart';

final apiClientProvider = Provider((ref) {
  return ApiClient();
});

final apiServiceProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ApiService(apiClient);
});

final categoryProvider = Provider((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return HomeDataRepository(apiService);
});

final bookProvider = FutureProvider.family<Books, String>((ref, id) async {
  final repository = ref.watch(categoryProvider);
  final response = await repository.getProduct(id);

  return response;
});

final imageProvider =
    FutureProvider.family<CoverImage, String>((ref, fileName) async {
  final repository = ref.watch(categoryProvider);
  final response = await repository.postCoverImage('$fileName.png');
  return response;
});

final searchProvider = StateProvider<String>((ref) => '');
