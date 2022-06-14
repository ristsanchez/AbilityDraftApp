import 'package:ability_draft/Abilities/AbilitiesAll.dart';
import 'package:ability_draft/Abilities/AbilitiesDBWorker.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'AppointmentsEntry.dart';
import 'AbilitiesModel.dart' show AbilitiesModel, abilitiesModel;
import 'AbilitiesHome.dart';

class Abilities extends StatelessWidget {
  Abilities() {
    // abilitiesModel.loadData(AbilitiesDBWorker.db);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AbilitiesModel>(
        model: abilitiesModel,
        child: ScopedModelDescendant<AbilitiesModel>(builder:
            (BuildContext context, Widget child, AbilitiesModel model) {
          return IndexedStack(
            index: model.stackIndex,
            children: <Widget>[AbilitiesAll()],
          );
        }));
  }
}
