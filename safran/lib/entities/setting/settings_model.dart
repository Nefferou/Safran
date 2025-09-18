import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  String _lang = 'fr';
  String _mode = 'cl';

  String get lang => _lang;
  String get mode => _mode;

  void setLang(String newLang) {
    _lang = newLang;
    notifyListeners();
  }

  void setMode(String newMode) {
    _mode = newMode;
    notifyListeners();
  }
}