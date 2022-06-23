import 'dart:ui';

import 'package:flutter/material.dart';

import '../heroes_objects/hero.dart';

showHeroDialog(BuildContext context, AHero hero) {
  Map<String, String> heroAttrs = heroFormattedStrings(hero);
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      contentPadding: const EdgeInsets.fromLTRB(0, 12, 0, 10),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  width: 1.5,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _getHeader(hero.base_name, hero.name, '', hero.att_type),
                  getLowDiv(),
                  _getIconsCol(heroAttrs),
                  getLowDiv(),
                  _abilities(context, hero),
                  _heroRolesGrid(
                      hero.roles_condensed, hero.role_levels_condensed),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

getLowDiv() {
  return const Divider(
    indent: 10,
    endIndent: 10,
    color: Color.fromARGB(132, 255, 255, 255),
    height: 10,
  );
}

_getHeader(String a, b, c, d) {
  return Container(
    padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
    color: Colors.transparent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/hero_portraits_big/$a.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: b,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              // RichText(
              //   textAlign: TextAlign.left,
              //   text: TextSpan(
              //     text: hero.primary_attr,
              //     style: TextStyle(
              //       fontSize: 16,
              //       color: hero.primary_attr == 'Strength'
              //           ? Colors.red
              //           : hero.primary_attr == 'Agility'
              //               ? Colors.greenAccent
              //               : Colors.lightBlue,
              //     ),
              //   ),
              // ),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: d,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

_getIconsCol(Map<String, String> values) {
  List<Widget> icons = [];

  values.forEach((iconName, value) {
    icons.add(_getIconLegend(iconName, value));
  });

  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: Column(
      children: [
        Row(
          children: icons.sublist(0, 3),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: icons.sublist(3, icons.length),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        )
      ],
    ),
  );
}

_getIconLegend(String iconName, value) {
  return Column(
    children: <Widget>[
      Image.asset(
        'assets/stats_icons_small/$iconName.png',
        fit: BoxFit.fill,
        height: 32,
        width: 32,
      ),
      Text(value),
    ],
  );
}

_abilities(BuildContext context, AHero data) {
  return Container(
    width: MediaQuery.of(context).size.width / 2,
    child: Column(
      children: [
        Text('Abilities'),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            abiImg(data.a1.toString()),
            abiImg(data.a2.toString()),
            abiImg(data.a3.toString()),
            abiImg(data.ult.toString()),
          ],
        ),
      ],
    ),
  );
}

abiImg(String name) {
  return SizedBox(
    height: 50,
    width: 50,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.asset(
        'assets/ability_images/$name.png',
        fit: BoxFit.fill,
      ),
    ),
  );
}

_heroRolesGrid(String? roles, levels) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Center(
            child: Text('Roles'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'M: ${roles!.substring(0, 8)}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const VerticalDivider(
                width: 10,
              ),
              Flexible(
                flex: 1,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: roles.substring(0, 8),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const VerticalDivider(
                width: 10,
              ),
              Flexible(
                flex: 1,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: roles.substring(0, 8),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Map<String, String> heroFormattedStrings(AHero hero) {
  String attackBase = hero.primary_attr == 'Strength'
      ? hero.base_str
      : hero.primary_attr == 'Agility'
          ? hero.base_agi
          : hero.base_int;

  return {
    'hero_strength': '${hero.base_str} + ${hero.str_per_level.substring(0, 3)}',
    'hero_agility': '${hero.base_agi} + ${hero.agi_per_level.substring(0, 3)}',
    'hero_intelligence':
        '${hero.base_int} + ${hero.int_per_level.substring(0, 3)}',
    'icon_armor': '${heroArmor(hero.base_armor, hero.base_agi)}',
    'icon_damage':
        '${int.parse(hero.base_damage_min) + int.parse(attackBase)} - ${int.parse(hero.base_damage_max) + int.parse(attackBase)}',
    'icon_movement_speed': '${hero.base_movement_speed}',
  };
}

heroArmor(String? base, agi) {
  return double.parse(
    (double.parse(base!) + (int.parse(agi!) / 6)).toStringAsFixed(2),
  );
}

/*
$LATER$ make 3 rows in the last column 2 rows with a double entry

-
-
-
 
- -
- 

*/
