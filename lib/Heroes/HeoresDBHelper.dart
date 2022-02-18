import 'package:sqflite/sqflite.dart';
import 'HeroesModel.dart';

abstract class HeroesDBWorker {
  static final HeroesDBWorker db = _SqfliteHeroesDBWorker._();

  /// Create and add the given hero in this database.
  Future<int> create(Hero hero);

  /// Update the given hero of this database.
  Future<void> update(Hero hero);

  /// Delete the specified hero.
  Future<void> delete(int id);

  /// Return the specified hero by id.
  Future<Hero> get(int id);

  /// Return all the heros of this database.
  Future<List<Hero>> getAll();
}

class _SqfliteHeroesDBWorker implements HeroesDBWorker {
  static const String DB_NAME = 'dota2.db';
  static const String TBL_NAME = 'heroes';

  //Variables from the game data
  static const String KEY_BASE_STR = 'base_str';

  //NEW
  static const String KEY_HERO_ID = 'id';
  static const String KEY_BASE_AGI = 'base_agi';
  static const String KEY_BASE_INT = 'base_int';
  static const String KEY_BASE_DAMAGE_MIN = 'base_damage_min';
  static const String KEY_BASE_DAMAGE_MAX = 'base_damage_max';
  static const String KEY_BASE_MSPEED = 'base_movement_speed';
  static const String KEY_BASE_ARMOR = 'base_armor';

  //NOT NEW
  static const String KEY_NAME = 'name';
  static const String KEY_TYPE = 'type';
  static const String KEY_PRIMARY_ATTR = 'primary_attr';

  //NEW (Doubles)
  static const String KEY_SPL = 'str_per_level';
  static const String KEY_APL = 'agi_per_level';
  static const String KEY_IPL = 'int_per_level';

  Database? _db;

  _SqfliteHeroesDBWorker._();

  Future<Database> get database async => _db ??= await _init();

  Future<Database> _init() async {
    return await openDatabase(DB_NAME, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE IF NOT EXISTS $TBL_NAME ("
          "$KEY_HERO_ID INTEGER PRIMARY KEY,"
          "$KEY_BASE_STR INTEGER,"
          "$KEY_BASE_AGI INTEGER,"
          "$KEY_BASE_INT INTEGER,"
          "$KEY_BASE_DAMAGE_MIN INTEGER,"
          "$KEY_BASE_DAMAGE_MAX INTEGER,"
          "$KEY_BASE_MSPEED INTEGER,"
          "$KEY_BASE_ARMOR INTEGER,"
          "$KEY_NAME TEXT,"
          "$KEY_TYPE TEXT,"
          "$KEY_PRIMARY_ATTR TEXT,"
          "$KEY_SPL TEXT,"
          "$KEY_APL TEXT,"
          "$KEY_IPL TEXT"
          ")");
    });
  }

  //DOUBLECHECK IF PARAMTERS MATCH AND EVERYTHING******************
  @override
  Future<int> create(Hero hero) async {
    Database db = await database;
    int id = await db.rawInsert(
        "INSERT INTO $TBL_NAME ($KEY_HERO_ID, $KEY_BASE_STR, $KEY_BASE_AGI, $KEY_BASE_INT, $KEY_BASE_DAMAGE_MIN, $KEY_BASE_DAMAGE_MAX, $KEY_BASE_MSPEED, $KEY_BASE_ARMOR, $KEY_NAME, $KEY_TYPE, $KEY_PRIMARY_ATTR, $KEY_SPL, $KEY_APL, $KEY_IPL) "
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [
          hero.id,
          hero.base_str,
          hero.base_agi,
          hero.base_int,
          hero.base_damage_min,
          hero.base_damage_max,
          hero.base_movement_speed,
          hero.base_armor,
          hero.name,
          hero.type,
          hero.primary_attr,
          hero.str_per_level,
          hero.agi_per_level,
          hero.int_per_level
        ]);
    return id;
  }

  @override
  Future<void> delete(int id) async {
    Database db = await database;
    await db.delete(TBL_NAME, where: "$KEY_HERO_ID = ?", whereArgs: [id]);
  }

  @override
  Future<void> update(Hero hero) async {
    Database db = await database;
    await db.update(TBL_NAME, _heroToMap(hero),
        where: "$KEY_HERO_ID = ?", whereArgs: [hero.id]);
  }

  @override
  Future<Hero> get(int id) async {
    Database db = await database;
    var values =
        //WE NEED TO TEST THIS TO SEE HOW IT RESPONDS********************
        //this was: $KEY_HERO_ID, the original genrated id
        await db.query(TBL_NAME, where: "$KEY_HERO_ID = ?", whereArgs: [id]);

    //Workaround line not working
    // return values.isEmpty ? null : _heroFromMap(values.first);
    if (values.isNotEmpty) {
      return _heroFromMap(values.first);
    }
    //lazy way of returning null
    return Hero(0, 0, 0, 0, 0, 0, 0, 0, "", "", "", 0, 0, 0);
  }

  @override
  Future<List<Hero>> getAll() async {
    Database db = await database;
    var values = await db.query(TBL_NAME);
    return values.isNotEmpty ? values.map((m) => _heroFromMap(m)).toList() : [];
  }

  //Oldmethod replaced by _heroFromMap below
  // Hero _heroFromMapOLD(Map map) {
  //   return Hero()
  //     ..id = map[KEY_HERO_ID]
  //     ..base_str = map[KEY_BASE_STR]
  //     ..name = map[KEY_NAME]
  //     ..type = map[KEY_TYPE]
  //     ..primary_attr = map[KEY_PRIMARY_ATTR];
  // }

  Hero _heroFromMap(Map map) {
    return Hero(
        map[KEY_HERO_ID],
        map[KEY_BASE_STR],
        map[KEY_BASE_AGI],
        map[KEY_BASE_INT],
        map[KEY_BASE_DAMAGE_MIN],
        map[KEY_BASE_DAMAGE_MAX],
        map[KEY_BASE_MSPEED],
        map[KEY_BASE_ARMOR],
        map[KEY_NAME],
        map[KEY_TYPE],
        map[KEY_PRIMARY_ATTR],
        map[KEY_SPL],
        map[KEY_APL],
        map[KEY_IPL]);
  }

  Map<String, dynamic> _heroToMap(Hero hero) {
    return Map<String, dynamic>()
      ..[KEY_HERO_ID] = hero.id
      ..[KEY_BASE_STR] = hero.base_str
      ..[KEY_BASE_AGI] = hero.base_agi
      ..[KEY_BASE_INT] = hero.base_int
      ..[KEY_BASE_DAMAGE_MIN] = hero.base_damage_min
      ..[KEY_BASE_DAMAGE_MAX] = hero.base_damage_max
      ..[KEY_BASE_MSPEED] = hero.base_movement_speed
      ..[KEY_BASE_ARMOR] = hero.base_armor
      ..[KEY_NAME] = hero.name
      ..[KEY_TYPE] = hero.type
      ..[KEY_PRIMARY_ATTR] = hero.primary_attr
      ..[KEY_SPL] = hero.str_per_level
      ..[KEY_APL] = hero.agi_per_level
      ..[KEY_IPL] = hero.int_per_level;
  }
}
