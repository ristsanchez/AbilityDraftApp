// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'hero_dialogs/hero_stats_dialog.dart';
import 'heroes_objects/hero.dart';

import 'package:cached_network_image/cached_network_image.dart';

class HeroesHome extends StatelessWidget {
  const HeroesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: _allHeroData(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            return _buildContents(context, snapshot.data);
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Loading...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      )

          // _buildContents(context, model),
          ),
    );
  }
}

Future<List<AHero>> _allHeroData(BuildContext context) async {
  String data = await DefaultAssetBundle.of(context)
      .loadString('lib/gameData/HeroesCond.json');
  //starts at the <nameofprojectdirectory> level, in this case "ability_draft"
  //Then we go to lib/utils and then find the file.
  Map<String, dynamic> map = json.decode(data);
  List<AHero> list = [];
  map.forEach((k, v) => list.add(AHero.fromJson(k, v, [])));
  return list;
}

//$CHECK$Do this when the app is opened
// _initializeDB(BuildContext context, Map<String, dynamic> data) {
//   AHero temp;
//   data.forEach((key, value) async {
//     temp = AHero.fromJson(value, key.toString());
//     await HeroesDBWorker.db.create(temp);
//   });
//   Scaffold.of(context).showSnackBar(const SnackBar(
//     backgroundColor: Colors.green,
//     duration: Duration(seconds: 1),
//     content: Text('Success'),
//   ));
// }

_buildContents(BuildContext context, List<AHero> heroList) {
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
              color: Colors.grey, // Yellow
              height: 27.0,
              alignment: Alignment.center,
            ),
            Container(
              // A fixed-height child.
              color: Colors.grey, // Yellow
              height: 70.0,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
              //get all from db, count it, display it as string
              child: getIconsFilterBar(context),
            ),
            Expanded(
              // A flexible child that will grow to fit the viewport but
              // still be at least as big as necessary to fit its contents.
              child: Container(
                color: Color.fromARGB(255, 110, 110, 110), // Red
                height: 120.0,
                alignment: Alignment.center,
                child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.78,
                      crossAxisCount: 3,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                    ),
                    itemCount: heroList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showHeroDialog(context, heroList[index]);
                        },
                        child: Stack(children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/${heroList[index].base_name}.png',
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
                                  text: heroList[index].name ?? "empty",
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

getIconsFilterBar(BuildContext context) {
  return Container(
    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              getElevatedButton('hero_strength'),
              getElevatedButton('hero_agility'),
              getElevatedButton('hero_intelligence'),
              Container(
                height: 35,
                width: 100,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'XP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('co'),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

getElevatedButton(String icon) {
  return ElevatedButton(
    onPressed: () {},
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 3,
          left: 1,
          child: Opacity(
              child: Image.asset(
                'assets/stats_icons_small/$icon.png',
                color: Colors.black,
                width: 30,
              ),
              opacity: 0.6),
        ),
        Positioned(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Image.asset(
                'assets/stats_icons_small/$icon.png',
                width: 30,
              ),
            ),
          ),
        ),
      ],
    ),
    style: ElevatedButton.styleFrom(
      shape: CircleBorder(),
      padding: EdgeInsets.all(4),
      primary: Color.fromARGB(255, 126, 126, 126), // <-- Button color
      onPrimary: Colors.white, // <-- Splash color
    ),
  );
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
