import 'package:dio/dio.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(baseUrl: "http://localhost:8080"),
  );

  static void setToken(String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }

  static void clearToken() {
    dio.options.headers.remove("Authorization");
  }
}