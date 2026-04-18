import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(baseUrl: "http://localhost:8080"),
  );

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final res = await dio.post(
      "/auth/login",
      data: {
        "email": email,
        "password": password,
      },
    );

    return res.data;
  }


  Future<Map<String, dynamic>> getMe(String token) async {
    final res = await dio.get(
      "/auth/me",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    return res.data;
  }
}