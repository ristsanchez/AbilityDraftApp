import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../AHero.dart';

Color? dom = Colors.grey[800];
Color? lig = Colors.grey[850];

showHeroDialog(BuildContext context, AHero hero) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: lig,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      contentPadding: const EdgeInsets.fromLTRB(0, 12, 0, 10),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
              color: lig,
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: dom,
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
                                fontWeight: (hero.primary_attr == 'Strength')
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
                                fontWeight: (hero.primary_attr == 'Agility')
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
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: 'Move-speed: ${hero.base_movement_speed}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 30,
                      ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text:
                              'Armor: ${heroArmor(hero.base_armor, hero.base_agi).toStringAsFixed(1)}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text:
                          'Damage: ${hero.base_damage_min}-${hero.base_damage_max}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 4,
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react//heroes/stats/icon_armor.png',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      //$LATER$ make sure progess indicator appears centered and right size
                      errorWidget: (context, url, error) => const Text('I'),
                    ),
                  ),
                ],
              ),
            ),
            _heroRolesGrid(hero.roles_condensed, hero.role_levels_condensed),
          ],
        ),
      ],
    ),
  );
}

_heroRolesGrid(String? roles, levels) {
  return Container(
    color: dom,
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