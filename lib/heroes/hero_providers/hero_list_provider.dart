import 'package:ability_draft/heroes/heroes_objects/hero.dart';
import 'package:ability_draft/utility_futures/json_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HeroListProvider extends ChangeNotifier {
  List<AHero> _fullList = [];
  List<AHero> _heroList = [];

  List<AHero> get list => _heroList;

  HeroListProvider();

  void setText(String text) {
    _heroList =
        _fullList.where((hero) => (hero.base_name.contains(text))).toList();
    notifyListeners();
  }

  //only if its not initialized
  initList() async {
    if (_fullList.isEmpty) {
      _fullList = await getAllHeroInfoList();

      _heroList = _fullList;
      notifyListeners();
    }
  }
}
