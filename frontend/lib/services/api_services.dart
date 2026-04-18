import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(baseUrl: "http://localhost:8080"),
  );

  void setToken(String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }

  Future login(String email, String password) async {
    final res = await dio.post("/auth/login", data: {
      "email": email,
      "password": password,
    });

    setToken(res.data["token"]);
    return res.data;
  }

  Future getUser() async {
    final res = await dio.get("/auth/me");
    return res.data;
  }
}