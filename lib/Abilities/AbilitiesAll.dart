import 'dart:convert';

import 'package:ability_draft/Abilities/AbilitiesDBWorker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

import '../utils/jsonUtils.dart';
import 'AbilitiesModel.dart';
import 'Ability.dart';
import 'AbilityStatsDialog.dart';

class AbilitiesAll extends StatelessWidget {
  const AbilitiesAll({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AbilitiesModel>(
        builder: (BuildContext context, Widget child, AbilitiesModel model) {
      return Scaffold(
        body: Center(
            child: FutureBuilder(
          future: _allAbiData(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              return _buildAbiContents(context, snapshot.data);
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            } else {
              return _buildEmpty(context);
            }
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

  Future<List<Ability>> _allAbiData(BuildContext context) async {
    String data2 = await DefaultAssetBundle.of(context)
        .loadString('lib/gameData/Abilitiesprog.json');
    String data = await DefaultAssetBundle.of(context)
        .loadString('lib/gameData/HeroesCond.json');
    String data3 = await DefaultAssetBundle.of(context)
        .loadString('lib/gameData/abilities_english.json');

    Map<String, dynamic> map = json.decode(data);
    Map<String, dynamic> map2 = json.decode(data2);
    Map<String, dynamic> map3 = json.decode(data3);

    List<Ability> res = [];
    List<int> djang = [1, 2, 3, 6];
    Map<String, String> temp = {};

    map.forEach((k, v) {
      // if (k == 'antimage' || k == 'axe') {
      for (int i in djang) {
        map3[k].forEach((descKey, descValue) {
          if (descKey
              .toString()
              .contains('DOTA_Tooltip_ability_${v['Ability$i']}')) {
            temp[descKey] = descValue;
          }
        });

        res.add(
          Ability.fromJson(v['Ability$i'], map2[v['Ability$i']], temp),
        );
        temp = {};
      }
    });
    return res;
  }
}

_buildBase(BuildContext context, List<Ability> abilityList) {
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
              color: const Color.fromARGB(255, 60, 97, 199), // Yellow
              height: 60.0,
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
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      childAspectRatio: 1,
                      crossAxisCount: 4,
                    ),
                    itemCount: abilityList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showAbilityDialog(context, abilityList[index]);
                        },
                        child: Stack(children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/${abilityList[index].name}.png',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              //$LATER$ make sure progess indicator appears centered and right size
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.one_x_mobiledata),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: abilityList[index].id,
                                  style: const TextStyle(
                                      fontSize: 16,
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

_buildAbiContents(BuildContext context, List<Ability> abilityList) {
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
              color: const Color.fromARGB(255, 60, 97, 199), // Yellow
              height: 60.0,
              alignment: Alignment.center,

              //get all from db, count it, display it as string
              child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.blueAccent,
                    duration: Duration(seconds: 1),
                    content: Text('Working'),
                  ));
                },
                child: CachedNetworkImage(
                  imageUrl:
                      'http://cdn.dota2.com/apps/dota2/images/heroes/axe_lg.png',
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
                color: Colors.blueGrey, // Red
                height: 120.0,
                alignment: Alignment.center,
                child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      childAspectRatio: 1,
                      crossAxisCount: 4,
                    ),
                    itemCount: abilityList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showAbilityDialog(context, abilityList[index]);
                        },
                        child: Stack(children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/${abilityList[index].name}.png',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              //$LATER$ make sure progess indicator appears centered and right size
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.one_x_mobiledata),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: abilityList[index].id,
                                  style: const TextStyle(
                                      fontSize: 16,
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

_buildEmpty(BuildContext context) {
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
              color: const Color.fromARGB(255, 60, 97, 199), // Yellow
              height: 60.0,
              alignment: Alignment.center,

              //get all from db, count it, display it as string
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
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      childAspectRatio: 1,
                      crossAxisCount: 4,
                    ),
                    itemCount: 32,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          color: Colors.blue,
                        ),
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
