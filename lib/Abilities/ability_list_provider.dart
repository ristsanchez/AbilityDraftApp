import 'dart:convert';

import 'package:ability_draft/Abilities/Ability.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AbilityListProvider extends ChangeNotifier {
  // List<Ability> abilityList = [];
  List<String> _hintList = [];
  List<Ability> _fullList = [];
  List<Ability> _abilityList = [];
  // UnmodifiableListView<Ability> get abilist => UnmodifiableListView(_fullList);
  List<Ability> get list => _abilityList;
  List<String> get abilityHintList => _hintList;

  AbilityListProvider();

  void setText(String text) {
    // _textNotifier.value = text;
    _abilityList =
        _fullList.where((ability) => (ability.name.contains(text))).toList();
    notifyListeners();
  }

  //only if its not initialized
  initializeList() {
    if (_fullList.isEmpty) {
      dallAbiData().whenComplete(() {
        _abilityList = _fullList;
        notifyListeners();
      });
    }
  }

  //refactor this to handle operations on object creation (-> constructor)
  Future<void> dallAbiData() async {
    String data2 =
        await rootBundle.loadString('lib/gameData/Abilitiesprog.json');
    String data = await rootBundle.loadString('lib/gameData/HeroesCond.json');
    String data3 =
        await rootBundle.loadString('lib/gameData/abilities_english.json');

    Map<String, dynamic> map = json.decode(data);
    Map<String, dynamic> map2 = json.decode(data2);
    Map<String, dynamic> map3 = json.decode(data3);

    List<Ability> res = [];
    List<int> djang = [1, 2, 3, 6];
    Map<String, String> temp = {};

    map.forEach((k, v) {
      // if (k == 'antimage' || k == 'axe') {
      for (int i in djang) {
        map3[k].forEach((descKey, descValue) {
          if (descKey
              .toString()
              .contains('DOTA_Tooltip_ability_${v['Ability$i']}')) {
            temp[descKey] = descValue;
          }
        });

        res.add(
          Ability.fromJson(v['Ability$i'], map2[v['Ability$i']], temp),
        );
        temp = {};
      }
    });
    // res.forEach((element) {
    //   _hintList.add(element.baseName ?? '');
    // });
    _fullList = res;
    // _abilityList = res;
    // notifyListeners();

    // return res;
  }
}
