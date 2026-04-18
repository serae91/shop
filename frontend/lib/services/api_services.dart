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
}