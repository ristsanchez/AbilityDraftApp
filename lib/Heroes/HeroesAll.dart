import 'dart:convert';

import 'package:ability_draft/Heroes/HeoresDBWorker.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'HeroesModel.dart';
import 'AHero.dart';

import 'package:cached_network_image/cached_network_image.dart';

class HeroesAll extends StatelessWidget {
  const HeroesAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HeroesModel>(
        builder: (BuildContext context, Widget child, HeroesModel model) {
      return Scaffold(
        body: Center(
          child: _buildContents(context, model),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.next_plan, color: Colors.white),
            onPressed: () async {
              model.setStackIndex(1);

              // Map<String, dynamic> tempPress;
              // tempPress = await loadAllHeroData(context);
              // initializeDB(context, tempPress);
            }),
      );
    });
  }

  //$CHECK$Do this when the app is opened
  initializeDB(BuildContext context, Map<String, dynamic> data) {
    AHero temp;
    data.forEach((key, value) async {
      temp = AHero.fromJson(value, key.toString());
      await HeroesDBWorker.db.create(temp);
    });
    Scaffold.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      duration: Duration(seconds: 1),
      content: Text('Success'),
    ));
  }
}

_buildContents(BuildContext context, HeroesModel model) {
  return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: viewportConstraints.maxHeight,
        ),
        child: IntrinsicHeight(
          child: Column(children: <Widget>[
            Container(
              // A fixed-height child.
              color: const Color(0xffeeee00), // Yellow
              height: 120.0,
              alignment: Alignment.center,

              //get all from db, count it, display it as string
              child: CachedNetworkImage(
                imageUrl:
                    'http://cdn.dota2.com/apps/dota2/images/heroes/axe_lg.png',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Text(error.toString()),
              ),
            ),
            Expanded(
              // A flexible child that will grow to fit the viewport but
              // still be at least as big as necessary to fit its contents.
              child: Container(
                color: Colors.blueGrey, // Red
                height: 120.0,
                alignment: Alignment.center,
                child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.66,
                      crossAxisCount: 3,
                    ),
                    itemCount: model.entryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _showHeroDialog(context, model.entryList[index]);
                        },
                        child: Stack(children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'http://cdn.dota2.com/apps/dota2/images/heroes/${model.entryList[index].base_name}_lg.png',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              //$LATER$ make sure progess indicator appears centered and right size
                              errorWidget: (context, url, error) =>
                                  Text(error.toString()),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: model.entryList[index].name ?? "empty",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          //$LAZY$ VERISON, FIND A WAY TO WRITE THE PROPER HERO NAME
                        ]),
                      );
                    }),
              ),
            )
          ]),
        ),
      ),
    );
  });
}

_tempCreateStats(HeroesModel model, BuildContext context) {
  // List<AHero> temst = [];
  // temst = await HeroesDBWorker.db.getAll();

  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 1),
    content: Text(model.entryList.length.toString()),
  ));
}

Color? dom = Colors.grey[800];
Color? lig = Colors.grey[700];

_showHeroDialog(BuildContext context, AHero hero) {
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
                            Text(error.toString()),
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
                                fontSize: 18),
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: primaryAtt(hero.primary_attr ?? ""),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: heroType(hero.type),
                            style: const TextStyle(color: Colors.white),
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
                        const Icon(
                          Icons.sensor_window_rounded,
                          color: Colors.red,
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                '${hero.base_str} + ${hero.str_per_level!.substring(0, 3)}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: (hero.primary_attr == 'str')
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
                        const Icon(
                          Icons.upcoming_sharp,
                          color: Colors.green,
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                '${hero.base_agi} + ${hero.agi_per_level!.substring(0, 3)}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: (hero.primary_attr == 'agi')
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
                        const Icon(
                          Icons.grain_sharp,
                          color: Colors.blue,
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                '${hero.base_int} + ${hero.int_per_level!.substring(0, 3)}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: (hero.primary_attr == 'int')
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
                ],
              ),
            ),
          ],
        ),
      ],
    ),
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

double heroArmor(String? base, int? agi) {
  return double.parse(base!) + (agi! / 6);
}

heroType(String? t) {
  return '${t!.substring(0, 1).toUpperCase()}${t.substring(1, t.length)}';
}

primaryAtt(String att) {
  switch (att) {
    case 'str':
      return "Strength";
    case 'agi':
      return "Agility";
    case 'int':
      return "Intelligence";
    default:
      return "";
  }
}
