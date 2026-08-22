import 'dart:convert';

import 'package:flutter/services.dart';

import '../config/app_config.dart';
import '../model/category_view.dart';
import 'dio_client.dart';

class CategoryService {
  static const String _endpoint = "/category";

  Future<List<CategoryView>> getCategories() async {
    if (AppConfig.useMockData) {
      final jsonString =
      await rootBundle.loadString('assets/data/categories.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      return jsonData
          .map(
            (json) => CategoryView.fromJson(
          json as Map<String, dynamic>,
        ),
      )
          .toList();
    }

    final res = await DioClient.dio.get("$_endpoint/categories");

    return (res.data as List)
        .map((e) => CategoryView.fromJson(e))
        .toList();
  }
}