// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

AbilitiesModel abilitiesModel = AbilitiesModel();

class AbilitiesModel extends Model {
  String temp = "temp";
  int stackIndex = 0;

  void setStackIndex(int stackIndex) {
    this.stackIndex = stackIndex;
    notifyListeners();
  }

  // initData() async {
  //   duration = Duration(seconds: 80);
  //   draft = await getDraftData();
  //   notifyListeners();
  // }
}

class Ability {
  Map<String, String> properties;
  int? id, pierces_spell_immunity;
  String? name, mana_cost, cooldown, damage, targets, affects, damage_type;

  Ability(
      this.id,
      this.pierces_spell_immunity,
      this.name,
      this.mana_cost,
      this.cooldown,
      this.damage,
      this.targets,
      this.affects,
      this.damage_type,
      this.properties);

  factory Ability.fromJson(dynamic json) {
    return Ability(
      int.parse(json['id']),
      int.parse(json['pierces_spell_immunity']),
      json['name'],
      json['mana_cost'],
      json['cooldown'],
      json['damage'],
      json['targets'],
      json['affects'],
      json['damage_type'],
      {"": ""},
    );
  }
  //$FINISH LATER$
  // @override
  // String toString() {
  //   return '{ ${this.name}, ${this.id}, ${this.base_str}, ${this.base_agi}, ${this.base_int}, ${this.base_damage_min}, ${this.base_damage_max}, ${this.base_movement_speed}, ${this.base_armor}, ${this.name}, ${this.type}, ${this.primary_attr}, ${this.str_per_level}, ${this.agi_per_level}, ${this.int_per_level} }';
  // }
}
