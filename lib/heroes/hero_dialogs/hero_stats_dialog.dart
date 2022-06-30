import 'dart:ui';

import 'package:flutter/material.dart';

import '../heroes_objects/hero.dart';

showHeroDialog(BuildContext context, AHero hero) {
  Map<String, String> heroAttrs = heroFormattedStrings(hero);
  List<String> heroHeaderAtts = [
    hero.base_name,
    hero.name,
    hero.primary_attr,
    hero.att_type
  ];

  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
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
                  _getHeader(heroHeaderAtts),
                  getLowDiv(),
                  _getIconsCol(heroAttrs),
                  getLowDiv(),
                  _abilities(context, hero),
                  getLowDiv(),
                  _heroRolesGrid(context, hero.roles),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

_heroRolesGrid(BuildContext context, Map roles) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
    child: Column(
      children: [
        const Text('Roles'),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: (roles.length / 3).round() * 40,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.3,
              crossAxisSpacing: 1,
            ),
            itemCount: roles.length,
            itemBuilder: (BuildContext context, int index) {
              List current = List.from(roles.keys);

              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '${current[index]}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: LinearProgressIndicator(
                        color: const Color.fromARGB(181, 255, 255, 255),
                        minHeight: 5,
                        value: roles[current[index]] / 3,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

getLowDiv() {
  return const Divider(
    indent: 15,
    endIndent: 15,
    color: Color.fromARGB(132, 255, 255, 255),
    height: 10,
  );
}

_getHeader(List<String> att) {
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
              'assets/hero_portraits_big/${att[0]}.png',
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
                  text: att[1],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: att[2],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: att[2] == 'Strength'
                        ? Colors.red
                        : att[2] == 'Agility'
                            ? Color.fromARGB(255, 13, 247, 5)
                            : Colors.lightBlue,
                  ),
                ),
              ),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: att[3],
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
    padding: const EdgeInsets.fromLTRB(0, 8, 0, 10),
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: Text(
            'Attributes',
          ),
        ),
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
    padding: const EdgeInsets.fromLTRB(15, 8, 15, 10),
    width: MediaQuery.of(context).size.width / 2,
    child: Column(
      children: [
        const Text('Abilities'),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    height: 58,
    width: 58,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.asset(
        'assets/ability_images/$name.png',
        fit: BoxFit.fill,
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
