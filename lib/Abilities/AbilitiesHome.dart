import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

import 'AbilitiesModel.dart';

class AbilitiesHome extends StatelessWidget {
  const AbilitiesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AbilitiesModel>(//Might get problems later
        builder: (BuildContext context, Widget child, AbilitiesModel model) {
      return Scaffold(
        body: Column(children: <Widget>[
          Expanded(
              child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(model.temp),
            //Missing stuff
          ))
        ]),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.place, color: Colors.white),
            onPressed: () {}),
      );
    });
  }
}

//Populate hero database with all heroes, start with 1
Future<List<String>> loadHeroNames(BuildContext context) async {
  String data =
      await DefaultAssetBundle.of(context).loadString('lib/utils/dota2.json');
  //starts at the <nameofprojectdirectory> level, in this case "ability_draft"
  //Then we go to lib/utils and then find the file.
  Map<String, dynamic> map = json.decode(data);
  List<String> oops = map.keys.toList();
  //REMOVE find better way to do
  return oops;
}
