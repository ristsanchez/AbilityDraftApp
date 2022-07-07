import '../../abilities/ability_objects/ability.dart';

/// A Hero object containing information, about its basic stats, abilities, etc.
///
/// This object represents the latest values of the current game patch
/// Source data comes directly from the game source files and is updated,
/// preprocessed and maintained by a separate python subsystem
///
/// Note: the class [Hero] was already taken by dart, therefore the name AHero
class AHero {
  ///

  /// Usually 3 regular and 1 ultimate abilities. Note: so many exceptions
  List<Ability>? abilityList;

  /// Map of roles in the form of String and Integer e.g., {"support" : 3, ...}
  Map roles;

  late String id,
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
    this.roles,
    this.magic_resist,
    this.abilityList,
  );

  /// Creates a [AHero] object from a json object
  ///
  /// It assumes data is in place, it's pre-made by a separate python subsystem
  factory AHero.fromJson(
    String baseName,
    dynamic json,
    List<Ability> abs,
  ) {
    Map myRoles = {};
    String roles = json["Role"] ?? '';
    String levels = json["Rolelevels"] ?? '';

    List rolesList = roles.split(',');
    List levs = levels.split(',');

    for (var i = 0; i < rolesList.length; i++) {
      myRoles[rolesList[i]] = double.parse(levs[i]);
    }

    return AHero(
      json["HeroID"] ?? '',
      json["workshop_guide_name"] ?? '',
      baseName,
      json["Ability2"] ?? '',
      json["Ability1"] ?? '',
      json["Ability3"] ?? '',
      json["Ability6"] ?? '',
      json["ArmorPhysical"] ?? '',
      (json["AttackCapabilities"] == 'DOTA_UNIT_CAP_MELEE_ATTACK'
          ? 'Melee'
          : 'Ranged'),
      json["AttackDamageMin"] ?? '',
      json["AttackDamageMax"] ?? '',
      json["AttackRate"] ?? '',
      json["AttackRange"] ?? '',
      (json["AttributePrimary"] == 'DOTA_ATTRIBUTE_AGILITY'
          ? 'Agility'
          : json["AttributePrimary"] == 'DOTA_ATTRIBUTE_STRENGTH'
              ? 'Strength'
              : 'Intelligence'), //'DOTA_ATTRIBUTE_INTELLECT'
      json["AttributeBaseStrength"] ?? '',
      json["AttributeStrengthGain"] ?? '',
      json["AttributeBaseIntelligence"] ?? '',
      json["AttributeIntelligenceGain"] ?? '',
      json["AttributeBaseAgility"] ?? '',
      json["AttributeAgilityGain"] ?? '',
      json["MovementSpeed"] ?? '',
      myRoles,
      json["MagicalResistance"] ?? '',
      abs,
    );
  }
  @override
  String toString() {
    return '${this.base_name}, ${this.name}, ${this.id}, ${this.base_str}, ${this.base_agi}, ${this.base_int}, ${this.base_damage_min}, ${this.base_damage_max}, ${this.base_movement_speed}, ${this.base_armor}, ${this.att_type}, ${this.primary_attr}, ${this.str_per_level}, ${this.agi_per_level}, ${this.int_per_level} ${this.abilities}';
  }
}
