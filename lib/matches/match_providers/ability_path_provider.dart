import 'package:flutter/foundation.dart';

class AbilityPathProvider extends ChangeNotifier {
  int _listIndex = 0;

  int get index => _listIndex;

  setIndex(int i) {
    _listIndex = i;
    if (i > 9) {
      _listIndex = 0;
    }
    notifyListeners();
  }
}
