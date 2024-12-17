import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/data/data_repository/api_client.dart';
import '../../../../shared/data/data_repository/api_service.dart';
import '../../../../shared/data/models/cover_image.dart';
import '../../../data/home_data_repository.dart';

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

final imageProvider =
    FutureProvider.family<CoverImage, String>((ref, fileName) async {
  final repository = ref.watch(homeProvider);
  final response = await repository.postCoverImage('$fileName.png');
  return response;
});
