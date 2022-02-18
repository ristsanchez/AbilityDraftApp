import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

HeroesModel heroesModel = HeroesModel();

class HeroesModel extends Model {
  int stackIndex = 0;
  Hero? curH;

  void setStackIndex(int stackIndex) {
    this.stackIndex = stackIndex;
    notifyListeners();
  }
// void loadData(database) async {
//     entryList.clear();
//     entryList.addAll(await database.getAll());
//     notifyListeners();
  // }

}

class Hero {
  int? id,
      base_str,
      base_agi,
      base_int,
      base_damage_min,
      base_damage_max,
      base_movement_speed,
      base_armor;
  String? name, type, primary_attr;
  double? str_per_level, agi_per_level, int_per_level;

  Hero(
      this.id,
      this.base_str,
      this.base_agi,
      this.base_int,
      this.base_damage_min,
      this.base_damage_max,
      this.base_movement_speed,
      this.base_armor,
      this.name,
      this.type,
      this.primary_attr,
      this.str_per_level,
      this.agi_per_level,
      this.int_per_level);
  factory Hero.fromJson(dynamic json) {
    return Hero(
        int.parse(json['id']),
        int.parse(json['base_str']),
        int.parse(json['base_agi']),
        int.parse(json['base_int']),
        int.parse(json['base_damage_min']),
        int.parse(json['base_damage_max']),
        int.parse(json['base_movement_speed']),
        int.parse(json['base_armor']),
        json['name'],
        json['type'],
        json['primary_attr'],
        double.parse(json['str_per_level']),
        double.parse(json['agi_per_level']),
        double.parse(json['int_per_level']));
  }
  @override
  String toString() {
    return '{ ${this.name}, ${this.id}, ${this.base_str}, ${this.base_agi}, ${this.base_int}, ${this.base_damage_min}, ${this.base_damage_max}, ${this.base_movement_speed}, ${this.base_armor}, ${this.name}, ${this.type}, ${this.primary_attr}, ${this.str_per_level}, ${this.agi_per_level}, ${this.int_per_level} }';
  }
}
