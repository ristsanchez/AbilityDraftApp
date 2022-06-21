import 'dart:convert';

import 'package:ability_draft/Abilities/Ability.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<List<String>> loadHeroNames(BuildContext context) async {
  String data =
      await DefaultAssetBundle.of(context).loadString('lib/utils/dota2.json');
  //starts at the <nameofprojectdirectory> level, in this case "ability_draft"
  //Then we go to lib/utils and then find the file.
  Map<String, dynamic> map = json.decode(data);
  List<String> oops = map.keys.toList();
  return oops;
}

Future<Map<String, dynamic>> heroData(BuildContext context) async {
  String data =
      await DefaultAssetBundle.of(context).loadString('lib/utils/dota2.json');
  //starts at the <nameofprojectdirectory> level, in this case "ability_draft"
  //Then we go to lib/utils and then find the file.
  Map<String, dynamic> map = json.decode(data);
  return map;
}

Future<Map<String, dynamic>> loadEngData(BuildContext context) async {
  String data = await DefaultAssetBundle.of(context)
      .loadString('lib/utils/abilities.json');
  //starts at the <nameofprojectdirectory> level, in this case "ability_draft"
  //Then we go to lib/utils and then find the file.
  Map<String, dynamic> map = json.decode(data);
  return map;
}

Future<String> getAbilityNameById(BuildContext context, int id) async {
  String data = await DefaultAssetBundle.of(context)
      .loadString('lib/utils/abiIdTable.json');
  //starts at the <nameofprojectdirectory> level, in this case "ability_draft"
  //Then we go to lib/utils and then find the file.
  Map<String, dynamic> map = json.decode(data);
  return map[id.toString()] ?? 'Error';
}

Future<List<Ability>> abiDataFuture() async {
  String data2 = await rootBundle.loadString('lib/gameData/Abilitiesprog.json');
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
  return res;
}




/*

https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/bracer.png
*/