class Player {
  List<int> abilityUpgrades, goldTime, xpTime, items;

  //units killed durring the game, creeps, heroes, neutrals etc
  Map<String, dynamic> killed;

  //hero name & number of times killed by
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
    this.level, //level at the end of game e.g., 27
    this.towerDamage,
    this.sentryUses,
    this.observerUses,
    //optional arguments
    // {
    // this.bae,
    // },
  );

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
      jsonData['isRadiant'] ?? false, //camelcase exception in json file
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
  //$FINISH LATER$
  // @override
  // String toString() {

  // }
}
