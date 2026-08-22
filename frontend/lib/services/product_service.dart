import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:frontend/config/app_config.dart';

import '../model/product_view.dart';
import 'dio_client.dart';

class ProductService {
  static const String _endpoint = "/product";

  Future<List<ProductView>> getProducts() async {
    if (AppConfig.useMockData) {
      final jsonString =
          await rootBundle.loadString('assets/data/products.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      return jsonData
          .map(
            (json) => ProductView.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
    }
    final res = await DioClient.dio.get("$_endpoint/products");

    return (res.data as List).map((e) => ProductView.fromJson(e)).toList();
  }
}
