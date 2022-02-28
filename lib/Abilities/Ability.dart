class Ability {
  // Map<String, String> properties;
  int? id, pierces_spell_immunity;
  String? name,
      mana_cost,
      cooldown,
      damage,
      targets,
      affects,
      damage_type,
      properties,
      fmt;

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
      this.properties,
      this.fmt);

  factory Ability.fromJson(
      dynamic json, String baseName, String formg, String props) {
    return Ability(
      int.parse(json['id']),
      json['pierces_spell_immunity'],
      baseName,
      json['mana_cost'],
      json['cooldown'],
      json['damage'],
      json['targets'],
      json['affects'],
      json['damage_type'],
      props,
      formg,
    );
  }
  //$FINISH LATER$
  // @override
  // String toString() {
  //   return '{ ${this.name}, ${this.id}, ${this.base_str}, ${this.base_agi}, ${this.base_int}, ${this.base_damage_min}, ${this.base_damage_max}, ${this.base_movement_speed}, ${this.base_armor}, ${this.name}, ${this.type}, ${this.primary_attr}, ${this.str_per_level}, ${this.agi_per_level}, ${this.int_per_level} }';
  // }
}


//make array of hero ids,
//get hero by id e.g. 1
  //get hero base_name e.g. antimage
//get hero abilities by ids e.g. 5004, 5005, ...
//for each main ability id
  //