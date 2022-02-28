import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'AHero.dart';

HeroesModel heroesModel = HeroesModel();

class HeroesModel extends Model {
  int stackIndex = 0;
  List<AHero> entryList = [];

  void setStackIndex(int stackIndex) {
    this.stackIndex = stackIndex;
    notifyListeners();
  }

  void loadData(Map<String, dynamic> data) {
    entryList.clear();
    data.forEach((key, value) {
      entryList.add(AHero.fromJson(value, key));
    });
    notifyListeners();
  }

  //This might not be possible since futures cannot be used in widget calls
  //$LATER$ method to get a hero name for url img
  //to be used when steam data is integrated
  String nameFromId() {
    return "axe";
  }
}
