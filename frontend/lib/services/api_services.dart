import 'package:dio/dio.dart';
import 'package:frontend/services/dio_client.dart';

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
    final res = await DioClient.dio.get(
      "/auth/me",
    );

    return res.data;
  }
}