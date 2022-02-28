import 'dart:convert';

import 'package:ability_draft/Heroes/HeoresDBWorker.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../utils/jsonUtils.dart';
import 'HeroDialogs/HeroStatsDialog.dart';
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
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.next_plan, color: Colors.white),
            onPressed: () async {
              model.setStackIndex(1);
            }),
      );
    });
  }
}

Future<List<AHero>> _allHeroData(BuildContext context) async {
  String data = await DefaultAssetBundle.of(context)
      .loadString('lib/gameData/HeroesCond.json');
  //starts at the <nameofprojectdirectory> level, in this case "ability_draft"
  //Then we go to lib/utils and then find the file.
  Map<String, dynamic> map = json.decode(data);
  List<AHero> list = [];
  map.forEach((k, v) => list.add(AHero.fromJson(k, v)));
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
              // A fixed-height child.
              color: Colors.black, // Yellow
              height: 120.0,
              alignment: Alignment.center,

              //get all from db, count it, display it as string
              child: GestureDetector(
                onTap: () async {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.blueAccent,
                    duration: Duration(seconds: 2),
                    content: Text('Working'),
                  ));
                  // Map<String, dynamic> tempPress;
                  // tempPress = await loadAllHeroData(context);
                  //_initializeDB(context, tempPress);
                },
                child: CachedNetworkImage(
                  imageUrl:
                      'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/axe.png',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Text(error.toString()),
                ),
              ),
            ),
            Expanded(
              // A flexible child that will grow to fit the viewport but
              // still be at least as big as necessary to fit its contents.
              child: Container(
                color: Colors.black, // Red
                height: 120.0,
                alignment: Alignment.center,
                child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.78,
                      crossAxisCount: 3,
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
