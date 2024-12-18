import 'package:ptn_assignment/shared/data/models/cover_image.dart';
import '../../shared/data/data_repository/api_service.dart';
import '../../shared/data/data_repository/shared_preferences.dart';
import '../../shared/helpers/jwt_helper.dart';

class BookDetailRepository {
  final ApiService apiService;

  BookDetailRepository(this.apiService);

  Future<CoverImage> postCoverImage(String fileName) async {
    final body = {
      'fileName': fileName,
    };
    final data = await apiService.postData('cover_image', body);

    return CoverImage.fromJson(data);
  }

  Future<CoverImage> likeImage(String id) async {
    final prefs = await SharedPreferencesManager.getInstance();

    var _user_id = extractUserIdFromToken(prefs.getString('user_token')!);
    final body = {
      "user_id": _user_id,
      "product_id": id,
    };
    final data = await apiService.postData('like', body);

    print(data);

    return CoverImage();
  }

  Future<CoverImage> unLikeImage(String id) async {
    final prefs = await SharedPreferencesManager.getInstance();

    var _user_id = extractUserIdFromToken(prefs.getString('user_token')!);
    final body = {
      "user_id": _user_id,
      "product_id": id,
    };
    final data = await apiService.postData('unlike', body);

    print(data);

    return CoverImage();
  }
}
