import 'package:flutter/material.dart';


class ThemeModel extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();

  ThemeData get currentTheme => _currentTheme;

  void setTheme(ThemeData newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
  }
}