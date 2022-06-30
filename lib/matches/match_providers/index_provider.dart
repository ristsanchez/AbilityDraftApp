import 'package:flutter/foundation.dart';

class IndexChangeProvider extends ChangeNotifier {
  bool _show = false;
  int _listIndex = 0;

  bool get show => _show;
  int get index => _listIndex;

  void toggleSwitch(bool condition) {
    _show = condition;
    notifyListeners();
  }

  void setIndex(int i) {
    _listIndex = i;
    notifyListeners();
  }
}
