import 'dart:convert';

import 'package:ability_draft/heroes/heroes_objects/hero.dart';
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

Future<Map<String, dynamic>> loadAllHeroData(BuildContext context) async {
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

//---recent---
//HERO HOME SCREEN UTIL
Future<List<AHero>> getAllHeroInfoList() async {
  String data = await rootBundle.loadString('lib/gameData/HeroesCond.json');
  Map<String, dynamic> map = json.decode(data);
  List<AHero> list = [];
  map.forEach((k, v) => list.add(AHero.fromJson(k, v, [])));
  return list;
}
