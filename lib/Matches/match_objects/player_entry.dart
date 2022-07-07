/// A player in a Dota 2 match, it only contains information regarding a match
///
/// The data to make a [Player] object is a subset of the Match Data
/// Both [MatchEntry] and [Player] objects are initialized sequentially
class Player {
  //
  /// List of gold and experience during the match,
  ///
  /// Where the index of the list represents the minute of the match,
  /// e.g. xpTime[10] = 4000, at minute 10 this player had 4000 xp
  List<int> goldTime, xpTime;

  List<int> items, abilityUpgrades;

  /// Units killed during the match, including creeps, heroes, neutrals, etc.
  Map<String, dynamic> killed;

  /// Hero unit names & numbers of times killed by
  /// ```dart
  /// killedBy = { "Lich" : 5, ... }
  /// ```
  Map<String, dynamic> killedBy;

  List<dynamic> killsLog;

  bool isRadiant;

  int heroId,
      playerSlot,
      kills,
      deaths,
      assists,
      denies,
      lastHits,
      netWorth,
      goldPerMin,
      xpPerMin,
      heroDamage,
      heroHealing,
      itemNeutral,

      /// Level of the player (hero) by the end of the match
      level,
      towerDamage,
      observerUses,
      sentryUses;

  Player(
    this.abilityUpgrades, //Int list att by minute
    this.goldTime,
    this.xpTime,
    this.items, // Int list att (1-6 slots)
    this.killed, // Map att
    this.killedBy,
    this.killsLog, // Map of dynamic
    this.isRadiant, // bool
    this.heroId, //ID Int attributes
    this.playerSlot,
    this.kills,
    this.deaths,
    this.assists,
    this.denies,
    this.lastHits,
    this.netWorth,
    this.goldPerMin,
    this.xpPerMin,
    this.heroDamage,
    this.heroHealing,
    this.itemNeutral,
    this.level,
    this.towerDamage,
    this.sentryUses,
    this.observerUses,
    //optional arguments
    // {
    // this.bae,
    // },
  );

  /// Creates a [Player] object from a json object
  ///
  /// It assumes data is in place, it's pre-made by a separate python subsystem
  factory Player.fromJson(Map<String, dynamic> jsonData) {
    List<int> itemList = [];
    for (int i = 0; i < 6; i++) {
      itemList.add(jsonData['item_$i'] ?? 0);
    }

    return Player(
      jsonData['ability_upgrades_arr'].cast<int>() ?? [],
      jsonData['gold_t'].cast<int>() ?? [],
      jsonData['xp_t'].cast<int>() ?? [],
      itemList,
      jsonData['killed'] ?? {},
      jsonData['killed_by'] ?? {},
      jsonData['kills_log'] ?? {},
      jsonData['isRadiant'] ?? false, //camel-case exception in json file
      jsonData['hero_id'] ?? -1,
      jsonData['player_slot'] ?? -1,
      jsonData['kills'] ?? -1,
      jsonData['deaths'] ?? -1,
      jsonData['assists'] ?? -1,
      jsonData['denies'] ?? -1,
      jsonData['last_hits'] ?? -1,
      jsonData['net_worth'] ?? -1,
      jsonData['gold_per_min'] ?? -1,
      jsonData['xp_per_min'] ?? -1,
      jsonData['hero_damage'] ?? -1,
      jsonData['hero_healing'] ?? -1,
      jsonData['item_neutral'] ?? -1,
      jsonData['level'] ?? -1,
      jsonData['tower_damage'] ?? -1,
      jsonData['observer_uses'] ?? -1,
      jsonData['sentry_uses'] ?? -1,
    );
  }
  //Missing toString() method

}
