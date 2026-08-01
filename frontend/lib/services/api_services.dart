import '../model/cart_view.dart';
import 'dio_client.dart';

class ApiService {
  Future<Map<String, dynamic>?> login(String email, String password) async {
    final res = await DioClient.dio.post(
      "/auth/login",
      data: {
        "email": email,
        "password": password,
      },
    );

    return res.data;
  }

  Future<Map<String, dynamic>> getMe() async {
    final res = await DioClient.dio.get("/auth/me");
    return res.data;
  }

  Future<CartView> addToCart(int productId, int quantity) async {
    final res = await DioClient.dio.post(
      "/cart/items",
      data: {
        "productId": productId,
        "quantity": quantity,
      },
    );

    return CartView.fromJson(res.data);
  }

  Future<CartView> updateCartItem(int productId, int quantity) async {
    final res = await DioClient.dio.put(
      "/cart/items/$productId",
      data: {
        "quantity": quantity,
      },
    );

    return CartView.fromJson(res.data);
  }
}
