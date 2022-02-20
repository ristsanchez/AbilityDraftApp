class AHero {
  int? id,
      base_str,
      base_agi,
      base_int,
      base_damage_min,
      base_damage_max,
      base_movement_speed;
  String? name,
      type,
      base_armor,
      primary_attr,
      str_per_level,
      agi_per_level,
      int_per_level,
      base_name;

  AHero(
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
      this.int_per_level,
      this.base_name);
  factory AHero.fromJson(dynamic json, String baseName) {
    return AHero(
        int.parse(json['id']),
        int.parse(json['base_str']),
        int.parse(json['base_agi']),
        int.parse(json['base_int']),
        int.parse(json['base_damage_min']),
        int.parse(json['base_damage_max']),
        int.parse(json['base_movement_speed']),
        json['base_armor'],
        json['name'],
        json['type'],
        json['primary_attr'],
        json['str_per_level'],
        json['agi_per_level'],
        json['int_per_level'],
        baseName);
  }
  @override
  String toString() {
    return '{ ${this.base_name}, ${this.name}, ${this.id}, ${this.base_str}, ${this.base_agi}, ${this.base_int}, ${this.base_damage_min}, ${this.base_damage_max}, ${this.base_movement_speed}, ${this.base_armor}, ${this.type}, ${this.primary_attr}, ${this.str_per_level}, ${this.agi_per_level}, ${this.int_per_level} }';
  }
}
