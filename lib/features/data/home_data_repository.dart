import 'package:ptn_assignment/shared/data/models/books.dart';
import 'package:ptn_assignment/shared/data/models/categories.dart';
import 'package:ptn_assignment/shared/data/models/cover_image.dart';
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
    final headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo0NTcsImVtYWlsIjoibXVyYXRAaG90bWFpbC5jb20iLCJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLXVzZXItaWQiOiI0NTciLCJ4LWhhc3VyYS1kZWZhdWx0LXJvbGUiOiJwdWJsaWMiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInB1YmxpYyIsInVzZXIiXX0sImlhdCI6MTczNDQzMDcyNCwiZXhwIjoxNzYwMzUwNzI0fQ.r23fRJ3P6TN8MqucxA8ZlcWJZ2wrFsO13xUlDHUhkT8',
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
