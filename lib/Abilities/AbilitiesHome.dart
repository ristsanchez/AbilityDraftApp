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
