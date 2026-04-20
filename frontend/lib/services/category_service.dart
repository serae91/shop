import '../model/category_view.dart';
import 'dio_client.dart';

class CategoryService {
  static const String _endpoint = "/category";

  Future<List<CategoryView>> getCategories() async {
    final res = await DioClient.dio.get("$_endpoint/categories");

    return (res.data as List)
        .map((e) => CategoryView.fromJson(e))
        .toList();
  }
}