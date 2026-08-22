import 'package:flutter/cupertino.dart';

import 'dio_client.dart';

class ConfigService extends ChangeNotifier {
  static const String _endpoint = "/config";
  bool _isShop = false;

  bool get isShop => _isShop;

  Future<void> loadShopMode() async {
    final res = await DioClient.dio.get("$_endpoint/shopmode");
    print("load shop mode ${res.data}");
    _isShop = res.data;
    notifyListeners();
  }
}
