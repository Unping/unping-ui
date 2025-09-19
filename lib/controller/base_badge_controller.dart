import 'package:flutter/foundation.dart';

class BaseBadgeController extends ChangeNotifier {
  bool isVisible;

  BaseBadgeController({this.isVisible = true});

  void remove() {
    isVisible = false;
    notifyListeners();
  }

  void show() {
    isVisible = true;
    notifyListeners();
  }
}
