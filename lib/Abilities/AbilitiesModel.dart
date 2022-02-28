// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

import 'Ability.dart';

AbilitiesModel abilitiesModel = AbilitiesModel();

class AbilitiesModel extends Model {
  int stackIndex = 0;

  List<Ability> abis = [];

  void setStackIndex(int stackIndex) {
    this.stackIndex = stackIndex;
    notifyListeners();
  }

  void loadData(database) async {
    abis.clear();
    abis.addAll(await database.getAll());
    notifyListeners();
  }
  // initData() async {
  //   duration = Duration(seconds: 80);
  //   draft = await getDraftData();
  //   notifyListeners();
  // }

}
