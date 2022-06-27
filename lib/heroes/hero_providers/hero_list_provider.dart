import 'dart:convert';

import 'package:ability_draft/heroes/heroes_objects/hero.dart';
import 'package:ability_draft/utility_futures/json_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HeroListProvider extends ChangeNotifier {
  List<AHero> _fullList = [];
  List<AHero> _abilityList = [];

  List<AHero> get list => _abilityList;

  HeroListProvider();

  void setText(String text) {
    // _textNotifier.value = text;
    _abilityList =
        _fullList.where((ability) => (ability.name.contains(text))).toList();
    notifyListeners();
  }

  //only if its not initialized
  initList() async {
    if (_fullList.isEmpty) {
      _fullList = await getAllHeroInfoList();

      _abilityList = _fullList;
      notifyListeners();
    }
  }
}
