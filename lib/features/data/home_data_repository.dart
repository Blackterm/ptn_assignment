import 'package:ptn_assignment/shared/data/models/books.dart';
import 'package:ptn_assignment/shared/data/models/categories.dart';
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
    final data = await apiService.getData(
      'products/$id',
    );
    return Books.fromJson(data);
  }
}
