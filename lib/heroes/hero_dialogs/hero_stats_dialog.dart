import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../heroes_objects/hero.dart';

Color? dom = Colors.grey[800];
Color? lig = Colors.grey[850];

showHeroDialog(BuildContext context, AHero hero) {
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
                  Container(
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
                            child: CachedNetworkImage(
                              imageUrl:
                                  'http://cdn.dota2.com/apps/dota2/images/heroes/${hero.base_name}_lg.png',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              //$LATER$ make sure progess indicator appears centered and right size
                              errorWidget: (context, url, error) =>
                                  Text(error.toString().substring(0, 10)),
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
                                  text: hero.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: hero.primary_attr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: hero.primary_attr == 'Strength'
                                        ? Colors.red
                                        : hero.primary_attr == 'Agility'
                                            ? Colors.greenAccent
                                            : Colors.lightBlue,
                                  ),
                                ),
                              ),
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: hero.att_type,
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
                  ),
                  const Divider(
                    indent: 10,
                    endIndent: 10,
                    color: Color.fromARGB(132, 255, 255, 255),
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_strength.png',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  //$LATER$ make sure progess indicator appears centered and right size
                                  errorWidget: (context, url, error) =>
                                      const Text('S'),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      '${hero.base_str} + ${hero.str_per_level!.substring(0, 3)}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                          (hero.primary_attr == 'Strength')
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_agility.png',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  //$LATER$ make sure progess indicator appears centered and right size
                                  errorWidget: (context, url, error) =>
                                      const Text('S'),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      '${hero.base_agi} + ${hero.agi_per_level!.substring(0, 3)}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                          (hero.primary_attr == 'Agility')
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_intelligence.png',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  //$LATER$ make sure progess indicator appears centered and right size
                                  errorWidget: (context, url, error) =>
                                      const Text('I'),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      '${hero.base_int} + ${hero.int_per_level!.substring(0, 3)}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                          (hero.primary_attr == 'Intelligence')
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react//heroes/stats/icon_damage.png',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  //$LATER$ make sure progess indicator appears centered and right size
                                  errorWidget: (context, url, error) =>
                                      const Text('S'),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      '${hero.base_damage_min}-${hero.base_damage_max}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react//heroes/stats/icon_armor.png',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  //$LATER$ make sure progess indicator appears centered and right size
                                  errorWidget: (context, url, error) =>
                                      const Text('A'),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      '${heroArmor(hero.base_armor, hero.base_agi).toStringAsFixed(1)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react//heroes/stats/icon_movement_speed.png',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  //$LATER$ make sure progess indicator appears centered and right size
                                  errorWidget: (context, url, error) =>
                                      const Text('I'),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '${hero.base_movement_speed}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    indent: 10,
                    endIndent: 10,
                    color: Color.fromARGB(132, 255, 255, 255),
                    height: 10,
                  ),
                  _abilities(context, hero),
                  const Divider(
                    indent: 10,
                    endIndent: 10,
                    color: Color.fromARGB(132, 255, 255, 255),
                    height: 10,
                  ),
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

_abilities(BuildContext context, AHero data) {
  return Container(
    width: MediaQuery.of(context).size.width / 2,
    child: Column(
      children: [
        Text('Abilities'),
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
      child: CachedNetworkImage(
        imageUrl:
            'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/${name}.png',
        placeholder: (context, url) => const CircularProgressIndicator(),
        //$LATER$ make sure progess indicator appears centered and right size
        errorWidget: (context, url, error) =>
            Center(child: Text(error.toString().substring(0, 4))),
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

double heroArmor(String? base, agi) {
  return double.parse(base!) + (int.parse(agi!) / 6);
}
/*
$LATER$ make 3 rows in the last column 2 rows with a double entry

-
-
-
 
- -
- 

*/
