import 'dart:convert';

import 'package:flutter/material.dart';

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
