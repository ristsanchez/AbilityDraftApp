import '../abilities/ability_objects/ability.dart';

class AHero {
  List<Ability>? abilityList;
  String? id,
      base_str,
      base_agi,
      base_int,
      base_damage_min,
      base_damage_max,
      base_movement_speed,
      name,
      att_type,
      base_armor,
      primary_attr,
      str_per_level,
      agi_per_level,
      int_per_level,
      base_name,
      abilities,
      a1,
      a2,
      a3,
      ult,
      att_rate,
      att_range,
      roles_condensed,
      role_levels_condensed,
      magic_resist;

  AHero(
    this.id,
    this.name,
    this.base_name,
    this.a1,
    this.a2,
    this.a3,
    this.ult,
    this.base_armor,
    this.att_type,
    this.base_damage_min,
    this.base_damage_max,
    this.att_rate,
    this.att_range,
    this.primary_attr,
    this.base_str,
    this.str_per_level,
    this.base_int,
    this.int_per_level,
    this.base_agi,
    this.agi_per_level,
    this.base_movement_speed,
    this.roles_condensed,
    this.role_levels_condensed,
    this.magic_resist,
    this.abilityList,
  );
  factory AHero.fromJson(
    String baseName,
    dynamic json,
    List<Ability> abs,
  ) {
    return AHero(
      json["HeroID"],
      json["workshop_guide_name"],
      baseName,
      json["Ability1"],
      json["Ability2"],
      json["Ability3"],
      json["Ability6"],
      json["ArmorPhysical"],
      (json["AttackCapabilities"] == 'DOTA_UNIT_CAP_MELEE_ATTACK'
          ? 'Melee'
          : 'Ranged'),
      json["AttackDamageMin"],
      json["AttackDamageMax"],
      json["AttackRate"],
      json["AttackRange"],
      (json["AttributePrimary"] == 'DOTA_ATTRIBUTE_AGILITY'
          ? 'Agility'
          : json["AttributePrimary"] == 'DOTA_ATTRIBUTE_STRENGTH'
              ? 'Strength'
              : 'Intelligence'), //'DOTA_ATTRIBUTE_INTELLECT'
      json["AttributeBaseStrength"],
      json["AttributeStrengthGain"],
      json["AttributeBaseIntelligence"],
      json["AttributeIntelligenceGain"],
      json["AttributeBaseAgility"],
      json["AttributeAgilityGain"],
      json["MovementSpeed"],
      json["Role"],
      json["Rolelevels"],
      json["MagicalResistance"],
      abs,
    );
  }
  @override
  String toString() {
    return '${this.base_name}, ${this.name}, ${this.id}, ${this.base_str}, ${this.base_agi}, ${this.base_int}, ${this.base_damage_min}, ${this.base_damage_max}, ${this.base_movement_speed}, ${this.base_armor}, ${this.att_type}, ${this.primary_attr}, ${this.str_per_level}, ${this.agi_per_level}, ${this.int_per_level} ${this.abilities}';
  }
}
