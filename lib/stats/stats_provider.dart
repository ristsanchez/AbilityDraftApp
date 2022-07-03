import 'package:ability_draft/matches/match_objects/index.dart';
import 'package:ability_draft/utility_futures/json_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StatsProvider extends ChangeNotifier {
  List<MatchEntry> _allMatches;

  List<MatchEntry> get list => _allMatches;

  StatsProvider() : _allMatches = [];

  //only if its not initialized
  initList() async {
    if (_allMatches.isEmpty) {
      _allMatches = await getMatchDataList();
      _allMatches.sort((a, b) => b.start_time.compareTo(a.start_time));
      notifyListeners();
    }
  }
}
