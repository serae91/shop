import 'package:flutter/cupertino.dart';

import '../config/app_config.dart';
import 'dio_client.dart';

class ConfigService extends ChangeNotifier {
  static const String _endpoint = "/config";
  bool _isShop = false;

  bool get isShop => _isShop;

  Future<void> loadShopMode() async {
    if (AppConfig.useMockData) {
      _isShop = false;
      notifyListeners();
      return;
    }

    final res = await DioClient.dio.get("$_endpoint/shopmode");
    print("load shop mode ${res.data}");
    _isShop = res.data;
    notifyListeners();
  }
}
