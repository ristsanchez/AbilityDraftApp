import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';
import 'MatchModel.dart' show MatchModel, matchModel;

import 'MatchesHome.dart';

class Matches extends StatelessWidget {
  const Matches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MatchModel>(
        model: matchModel,
        child: ScopedModelDescendant<MatchModel>(
            builder: (BuildContext context, Widget child, MatchModel model) {
          return IndexedStack(
            index: model.stackIndex,
            children: const <Widget>[
              MatchesHome(),
            ],
          );
        }));
  }
}
