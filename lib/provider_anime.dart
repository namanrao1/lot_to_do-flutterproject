import 'package:flutter/material.dart';

class AnimatiProvider with ChangeNotifier {
  bool selected = false;

  void toggleSelected() {
    selected = !selected;
    notifyListeners();
  }
}
