import 'player_entry.dart';

/// A summary of a match in (level 2) detailed data (parsed from a json object)
///
/// Level 2 stands for detailed enough to have a better understanding of
/// All the players levels, items, kills, deaths, etc.
///
/// Also, the data comes from the dota open api: [https://docs.opendota.com/]
/// And it is preprocessed before introducing it to the (whole) App component
class MatchEntry {
  ///
  ///List of [Player] objects in a particular match (commonly 10)
  List<Player> playerList;

  /// Lists of gold and xp, where the index represent a minute of the match
  /// and the value the respective advantage for the radiant team
  /// Note: a negative value means radiant is losing, or Dire has an advantage
  List<int> radiantGoldAdv, radiantXpAdv;

  bool radiantWin;
  int matchId,
      direScore,
      radiantScore,
      duration,
      gameMode,
      humanPlayers,
      lobbyType,
      start_time;

  MatchEntry(
    this.radiantWin,
    this.radiantGoldAdv,
    this.radiantXpAdv,
    this.matchId,
    this.direScore,
    this.radiantScore,
    this.duration,
    this.gameMode,
    this.humanPlayers, //number of players in match eg 5v5 = 10 players
    this.lobbyType,

    /// optional arguments
    /// ```dart
    /// { this.variable,},
    /// ```
    this.playerList,
    this.start_time,
  );

  /// Creates a Match entry object from [json] data
  ///
  /// It assumes data is in place, it's pre-made by a separate python subsystem
  factory MatchEntry.fromJson(Map<String, dynamic> jsonData) {
    List<Player> playerList = [];

    List<dynamic> jsonPlayerList = jsonData['players'] ?? [];

    for (var jsonPlayer in jsonPlayerList) {
      playerList.add(Player.fromJson(jsonPlayer));
    }

    return MatchEntry(
      jsonData['radiant_win'] ?? false,
      jsonData['radiant_gold_adv'].cast<int>() ?? [],
      jsonData['radiant_xp_adv'].cast<int>() ?? [],
      jsonData['match_id'] ?? 0,
      jsonData['dire_score'] ?? 0,
      jsonData['radiant_score'] ?? 0,
      jsonData['duration'] ?? 0,
      jsonData['game_mode'] ?? 0,
      jsonData['human_players'] ?? 0,
      jsonData['lobby_type'] ?? 0,
      playerList,
      jsonData['start_time'] ?? 0,
    );
  }

  //Missing toString method with @overridE toString()

  /// Returns the Radiant players marked using the [isRadiant] condition
  List<Player> getRadiantPlayers() {
    List<Player> temp = [];
    playerList.forEach((player) {
      if (player.isRadiant) {
        temp.add(player);
      }
    });
    return temp;
  }

  /// Returns the Dire players marked using the [isRadiant] condition
  List<Player> getDirePlayers() {
    List<Player> temp = [];
    playerList.forEach((player) {
      if (!player.isRadiant) {
        temp.add(player);
      }
    });
    return temp;
  }
}
