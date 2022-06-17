class MatchEntry {
  bool radiantWin;
  List<int> radiantGoldAdv, radiantXpAdv;
  int matchId, direScore, duration, gameMode, humanPlayers, lobbyType;

  MatchEntry(
    this.radiantWin,
    this.radiantGoldAdv,
    this.radiantXpAdv,
    this.matchId,
    this.direScore,
    this.duration,
    this.gameMode,
    this.humanPlayers, //number of players in match eg 5v5 = 10 players
    this.lobbyType,
    //optional arguments
    // {
    // this.bae,
    // },
  );

  factory MatchEntry.fromJson(Map<String, dynamic> jsonData) {
    return MatchEntry(
      jsonData['radiant_win'] ?? false,
      jsonData['radiant_gold_adv'] ?? [],
      jsonData['radiant_xp_adv'] ?? [],
      jsonData['match_id'] ?? 0,
      jsonData['dire_score'] ?? 0,
      jsonData['duration'] ?? 0,
      jsonData['game_mode'] ?? 0,
      jsonData['human_players'] ?? 0,
      jsonData['lobby_type'] ?? 0,
    );
  }
  //$FINISH LATER$
  // @override
  // String toString() {
  //   return '{ ${this.name}, ${this.id}, ${this.base_str}, ${this.base_agi}, ${this.base_int}, ${this.base_damage_min}, ${this.base_damage_max}, ${this.base_movement_speed}, ${this.base_armor}, ${this.name}, ${this.type}, ${this.primary_attr}, ${this.str_per_level}, ${this.agi_per_level}, ${this.int_per_level} }';
  // }
}
