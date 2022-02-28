import 'package:sqflite/sqflite.dart';
import 'AbilitiesModel.dart';
import 'Ability.dart';

abstract class AbilitiesDBWorker {
  static final AbilitiesDBWorker db = _SqfliteAbilitiesDBWorker._();

  /// Create and add the given ability in this database.
  Future<int> create(Ability ability);

  /// Update the given ability of this database.
  Future<void> update(Ability ability);

  /// Delete the specified ability.
  Future<void> delete(int id);

  /// Return the specified ability by id.
  Future<Ability> get(int id);

  /// Return all the abilitys of this database.
  Future<List<Ability>> getAll();
}

// names dot2.db azufre,
class _SqfliteAbilitiesDBWorker implements AbilitiesDBWorker {
  static const String DB_NAME = 'lkajsd.db';
  static const String TBL_NAME = 'abilities';

  //$CHECK$ which id to use and how and if it it works even***
  static const String KEY_ID = '_id';

  //Variables from the game data
  static const String KEY_AID = 'id';
  static const String KEY_PIERCES = 'pierces_spell_immunity';

  static const String KEY_NAME = 'name';
  static const String KEY_COST = 'mana_cost';
  static const String KEY_CD = 'cooldown';
  static const String KEY_DMG = 'damage';
  static const String KEY_TARGETS = 'targets';
  static const String KEY_AFFECTS = 'affects';
  static const String KEY_DMG_TYPE = 'damage_type';

  static const String KEY_PPT = 'properties';
  static const String KEY_FMT = 'formatting';

  Database? _db;

  _SqfliteAbilitiesDBWorker._();

  Future<Database> get database async => _db ??= await _init();

  Future<Database> _init() async {
    return await openDatabase(DB_NAME, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      //$CHECK$ which id to use, if private or aid id
      await db.execute("CREATE TABLE IF NOT EXISTS $TBL_NAME ("
          "$KEY_AID INTEGER PRIMARY KEY,"
          "$KEY_PIERCES INTEGER,"
          "$KEY_NAME TEXT,"
          "$KEY_COST TEXT,"
          "$KEY_CD TEXT,"
          "$KEY_DMG TEXT,"
          "$KEY_TARGETS TEXT,"
          "$KEY_AFFECTS TEXT,"
          "$KEY_DMG_TYPE TEXT,"
          "$KEY_PPT TEXT,"
          "$KEY_FMT TEXT"
          ")");
      //MAKE SURE STRUCTURE IS CONSISTENT TO AVOID RUNTIME ERRORS
    });
  }

  //DOUBLECHECK IF PARAMTERS MATCH AND EVERYTHING******************
  @override
  Future<int> create(Ability ability) async {
    Database db = await database;
    int id = await db.rawInsert(
        "INSERT INTO $TBL_NAME ($KEY_AID, $KEY_PIERCES, $KEY_NAME, $KEY_COST, $KEY_CD, $KEY_DMG, $KEY_TARGETS, $KEY_AFFECTS, $KEY_DMG_TYPE, $KEY_PPT, $KEY_FMT) "
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [
          ability.id,
          ability.pierces_spell_immunity,
          ability.name,
          ability.mana_cost,
          ability.cooldown,
          ability.damage,
          ability.targets,
          ability.affects,
          ability.damage_type,
          ability.properties,
          ability.fmt
        ]);
    return id;
  }

  @override
  Future<void> delete(int id) async {
    Database db = await database;
    await db.delete(TBL_NAME, where: "$KEY_AID = ?", whereArgs: [id]);
  }

  @override
  Future<void> update(Ability ability) async {
    Database db = await database;
    await db.update(TBL_NAME, _abilityToMap(ability),
        where: "$KEY_AID = ?", whereArgs: [ability.id]);
  }

  @override
  Future<Ability> get(int id) async {
    Database db = await database;
    var values =
        //WE NEED TO TEST THIS TO SEE HOW IT RESPONDS********************
        //this was: $KEY_ID, the original genrated id
        await db.query(TBL_NAME, where: "$KEY_AID = ?", whereArgs: [id]);

    //Workaround line not working
    // return values.isEmpty ? null : _abilityFromMap(values.first);
    if (values.isNotEmpty) {
      return _abilityFromMap(values.first);
    }
    //lazy way of returning null
    return Ability(0, 0, "", "", "", "", "", "", "", "", "");
  }

  @override
  Future<List<Ability>> getAll() async {
    Database db = await database;
    var values = await db.query(TBL_NAME);
    return values.isNotEmpty
        ? values.map((m) => _abilityFromMap(m)).toList()
        : [];
  }

  Ability _abilityFromMap(Map map) {
    return Ability(
      map[KEY_AID],
      map[KEY_PIERCES],
      map[KEY_NAME],
      map[KEY_COST],
      map[KEY_CD],
      map[KEY_DMG],
      map[KEY_TARGETS],
      map[KEY_AFFECTS],
      map[KEY_DMG_TYPE],
      map[KEY_PPT],
      map[KEY_FMT],
    );
  }

  //$CHECK$ how to add properties before testing
  Map<String, dynamic> _abilityToMap(Ability ability) {
    return Map<String, dynamic>()
      ..[KEY_AID] = ability.id
      ..[KEY_PIERCES] = ability.pierces_spell_immunity
      ..[KEY_NAME] = ability.name
      ..[KEY_COST] = ability.mana_cost
      ..[KEY_CD] = ability.cooldown
      ..[KEY_DMG] = ability.damage
      ..[KEY_TARGETS] = ability.targets
      ..[KEY_AFFECTS] = ability.affects
      ..[KEY_DMG_TYPE] = ability.damage_type
      ..[KEY_PPT] = ability.properties
      ..[KEY_FMT] = ability.fmt;
  }
}

//Oldmethod replaced by _abilityFromMap below
// Ability _abilityFromMapOLD(Map map) {
//   return Ability()
//     ..id = map[KEY_ID]
//     ..pierces_spell_immunity = map[KEY_PIERCES]
//     ..name = map[KEY_NAME]
//     ..type = map[KEY_TYPE]
//     ..primary_attr = map[KEY_PRIMARY_ATTR];
// }
