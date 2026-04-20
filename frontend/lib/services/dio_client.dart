import 'package:dio/dio.dart';

import 'auth_service.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(baseUrl: "http://localhost:8080"),
  );

  static void init(AuthService auth) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = auth.token;

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    );
  }
}