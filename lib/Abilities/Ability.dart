class Ability {
  Map<String, String> propertyDescriptions;
  String id, name, description;
  String? baseName,
      type,
      behavior,
      castRange,
      castPoint,
      channelTime,
      charges,
      chargeRestoreTime,
      cooldown,
      duration,
      damage,
      manaCost,
      unitDamageType,
      spellImmunityType,
      special,
      values,
      unitTargetTeam,
      hasScepterUpgrade,
      spellDispellableType,
      hasShardUpgrade,
      unitTargetType,
      isGrantedByScepter,
      isGrantedByShard,
      linkedAbility,
      isShardUpgrade;

  Ability(
    this.propertyDescriptions,
    this.id,
    this.name,
    this.description, {

    //optional arguments
    this.baseName,
    this.type,
    this.behavior,
    this.castRange,
    this.castPoint,
    this.channelTime,
    this.charges,
    this.chargeRestoreTime,
    this.cooldown,
    this.duration,
    this.damage,
    this.manaCost,
    this.unitDamageType,
    this.spellImmunityType,
    this.special,
    this.values,
    this.unitTargetTeam,
    this.hasScepterUpgrade,
    this.spellDispellableType,
    this.hasShardUpgrade,
    this.unitTargetType,
    this.isGrantedByScepter,
    this.isGrantedByShard,
    this.linkedAbility,
    this.isShardUpgrade,
  });

  factory Ability.fromJson(
      String key, Map<String, dynamic> json, Map<String, String> props) {
    return Ability(
      props,
      json['ID'] ?? '0',
      key,
      props['DOTA_Tooltip_ability_${key}_Description'].toString(),
      baseName: props['DOTA_Tooltip_ability_$key'],
      type: json['AbilityType'] ?? 'DOTA_ABILITY_TYPE_BASIC',
      behavior: json['AbilityBehavior'] ?? 'DOTA_ABILITY_BEHAVIOR_NONE',
      castRange: json['AbilityCastRange'] ?? '0',
      castPoint: json['AbilityCastPoint'] ?? '',
      channelTime: json['AbilityChannelTime'] ?? '',
      charges: json['AbilityCharges'] ?? '',
      chargeRestoreTime: json['AbilityChargeRestoreTime'] ?? '',
      cooldown: json['AbilityCooldown'] ?? '',
      duration: json['AbilityDuration'] ?? '',
      damage: json['AbilityDamage'] ?? '',
      manaCost: json['AbilityManaCost'] ?? '',
      unitDamageType: json['AbilityUnitDamageType'] ?? '',
      spellImmunityType: json['SpellImmunityType'] ?? '',
      special: json['AbilitySpecial'].toString(), //map of string/dynamic
      values: json['AbilityValues'].toString(), //map of string/dynamic
      unitTargetTeam: json['AbilityUnitTargetTeam'] ?? '',
      hasScepterUpgrade: json['HasScepterUpgrade'] ?? '',
      spellDispellableType: json['SpellDispellableType'] ?? '',
      hasShardUpgrade: json['HasShardUpgrade'] ?? '',
      unitTargetType: json['AbilityUnitTargetType'] ?? '',
      isGrantedByScepter: json['IsGrantedByScepter'] ?? '',
      isGrantedByShard: json['IsGrantedByShard'] ?? '',
      linkedAbility: json['LinkedAbility'] ?? '',
      isShardUpgrade: json['IsShardUpgrade'] ?? '',
    );
  }
  //$FINISH LATER$
  // @override
  // String toString() {
  //   return '{ ${this.name}, ${this.id}, ${this.base_str}, ${this.base_agi}, ${this.base_int}, ${this.base_damage_min}, ${this.base_damage_max}, ${this.base_movement_speed}, ${this.base_armor}, ${this.name}, ${this.type}, ${this.primary_attr}, ${this.str_per_level}, ${this.agi_per_level}, ${this.int_per_level} }';
  // }
}

List shoe = [
  'ID',
  'AbilityType',
  'AbilityBehavior',
  'AbilityCastRange',
  'AbilityCastPoint',
  'AbilityChannelTime',
  'AbilityCooldown',
  'AbilityDuration',
  'AbilityDamage',
  'AbilityManaCost',
  'AbilityUnitDamageType',
  'SpellImmunityType',
  'AbilitySpecial',
  'HasScepterUpgrade',
  'AbilityValues',
  'SpellDispellableType',
  'HasShardUpgrade',
  'AbilityUnitTargetTeam',
  'AbilityUnitTargetType',
  'IsGrantedByScepter',
  'AbilityCharges',
  'AbilityChargeRestoreTime',
  'IsGrantedByShard',
  'LinkedAbility',
  'IsShardUpgrade'
];
