import 'package:ptn_assignment/shared/data/models/books.dart';
import 'package:ptn_assignment/shared/data/models/categories.dart';
import 'package:ptn_assignment/shared/data/models/cover_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/data/data_repository/api_service.dart';

class HomeDataRepository {
  final ApiService apiService;

  HomeDataRepository(this.apiService);

  Future<Categories> getCategory() async {
    final data = await apiService.getData(
      'categories',
    );

    return Categories.fromJson(data);
  }

  Future<Books> getProduct(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String? _token = prefs.getString('user_token');
    final headers = {
      'Authorization': 'Bearer $_token',
    };
    final data = await apiService.getData(
      'products/$id',
      headers: headers,
    );

    return Books.fromJson(data);
  }

  Future<CoverImage> postCoverImage(String fileName) async {
    final body = {
      'fileName': fileName,
    };
    final data = await apiService.postData('cover_image', body);

    return CoverImage.fromJson(data);
  }
}
