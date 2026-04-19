import '../model/product_view.dart';
import 'dio_client.dart';

class ProductService {
  static const String _endpoint = "/product";

  Future<List<ProductView>> getProducts() async {
    final res = await DioClient.dio.get("$_endpoint/products");

    return (res.data as List)
        .map((e) => ProductView.fromJson(e))
        .toList();
  }
}