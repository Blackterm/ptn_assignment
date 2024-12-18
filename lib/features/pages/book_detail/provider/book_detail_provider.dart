import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptn_assignment/features/data/book_detail_repository.dart';
import 'package:ptn_assignment/features/data/home_data_repository.dart';
import '../../../../shared/data/data_repository/api_client.dart';
import '../../../../shared/data/data_repository/api_service.dart';
import '../../../../shared/data/models/books.dart';
import '../../../../shared/data/models/cover_image.dart';

final apiClientProvider = Provider((ref) {
  return ApiClient();
});

final apiServiceProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ApiService(apiClient);
});

final bookDetailProvider = Provider((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return BookDetailRepository(apiService);
});

final imageProvider =
    FutureProvider.family<CoverImage, String>((ref, fileName) async {
  final repository = ref.watch(bookDetailProvider);
  final response = await repository.postCoverImage('$fileName.png');
  return response;
});

final likeImageProvider =
    FutureProvider.family<CoverImage, String>((ref, id) async {
  final repository = ref.watch(bookDetailProvider);
  final response = await repository.likeImage(id);

  return response;
});

final unLikeImageProvider =
    FutureProvider.family<CoverImage, String>((ref, id) async {
  final repository = ref.watch(bookDetailProvider);
  final response = await repository.unLikeImage(id);

  return response;
});
