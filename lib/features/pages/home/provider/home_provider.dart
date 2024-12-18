import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptn_assignment/features/data/home_data_repository.dart';
import 'package:ptn_assignment/shared/data/models/books.dart';
import 'package:ptn_assignment/shared/data/models/categories.dart';
import 'package:ptn_assignment/shared/data/models/cover_image.dart';
import '../../../../shared/data/data_repository/api_client.dart';
import '../../../../shared/data/data_repository/api_service.dart';
import '../../../../shared/data/data_repository/shared_preferences.dart';
import '../../book_detail/provider/book_detail_provider.dart';

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

final categoryHomeProvider = FutureProvider<Categories>((ref) async {
  const cacheKey = 'category_cache';
  const cacheTimeKey = 'category_cache_time';

  final prefs = await SharedPreferencesManager.getInstance();

  final cacheData = prefs.getString(cacheKey);
  final cacheTime = prefs.getInt(cacheTimeKey);
  final currentTime = DateTime.now().millisecondsSinceEpoch;

  if (cacheData != null &&
      cacheTime != null &&
      (currentTime - cacheTime) < 24 * 60 * 60 * 1000) {
    final decodedData = jsonDecode(cacheData);
    return Categories.fromJson(decodedData);
  }

  final repository = ref.watch(homeProvider);
  final response = await repository.getCategory();

  prefs.setString(cacheKey, jsonEncode(response.toJson()));
  prefs.setInt(cacheTimeKey, currentTime);

  return response;
});

final bookHomeProvider = FutureProvider.family<Books, String>((ref, id) async {
  final prefs = await SharedPreferencesManager.getInstance();
  final cacheKey = 'book_cache_$id';
  final cacheTimeKey = 'book_cache_time_$id';

  final shouldForceRefresh = ref.watch(forceRefreshProvider);

  if (!shouldForceRefresh) {
    final cacheData = prefs.getString(cacheKey);
    final cacheTime = prefs.getInt(cacheTimeKey);
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (cacheData != null &&
        cacheTime != null &&
        (currentTime - cacheTime) < 24 * 60 * 60 * 1000) {
      final decodedData = jsonDecode(cacheData);
      return Books.fromJson(decodedData);
    }
  }

  final repository = ref.watch(homeProvider);
  final response = await repository.getProduct(id);

  prefs.setString(cacheKey, jsonEncode(response.toJson()));
  prefs.setInt(cacheTimeKey, DateTime.now().millisecondsSinceEpoch);
  ref.read(forceRefreshProvider.notifier).state = false;
  return response;
});

final imageHomeProvider =
    FutureProvider.family<CoverImage, String>((ref, fileName) async {
  final repository = ref.watch(homeProvider);
  final response = await repository.postCoverImage('$fileName.png');
  return response;
});

final selectedCategoryIdProvider = StateProvider<int>((ref) => 0);
final searchQueryProvider = StateProvider<String>((ref) => '');
