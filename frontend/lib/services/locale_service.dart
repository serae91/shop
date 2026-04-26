import 'package:flutter/cupertino.dart';

class LocaleService extends ChangeNotifier {
  Locale _locale = const Locale('zh');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
