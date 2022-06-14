import 'package:scoped_model/scoped_model.dart';

MatchModel matchModel = MatchModel();

class MatchModel extends Model {
  int stackIndex = 0;
  String entryList = '';

  void setStackIndex(int stackIndex) {
    this.stackIndex = stackIndex;
    notifyListeners();
  }
}
