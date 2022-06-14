import 'package:ability_draft/Heroes/HeroesAll.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'AppointmentsEntry.dart';
import 'HeroesModel.dart' show HeroesModel, heroesModel;
import 'HeroesHome.dart';

class Heroes extends StatelessWidget {
  Heroes() {
    // heroesModel.loadData(HeroesDBWorker.db);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<HeroesModel>(
        model: heroesModel,
        child: ScopedModelDescendant<HeroesModel>(
            builder: (BuildContext context, Widget child, HeroesModel model) {
          return IndexedStack(
            index: model.stackIndex,
            children: const <Widget>[HeroesAll(), HeroesHome()],
          );
        }));
  }
}

// var heroList = {
//   1,
//   2,
//   3,
//   4,
//   5,
//   6,
//   7,
//   8,
//   9,
//   10,
//   11,
//   12,
//   13,
//   14,
//   15,
//   16,
//   17,
//   18,
//   19
// };
