import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'HeroesModel.dart';

Future<List<String>> loadHeroNames(BuildContext context) async {
  String data =
      await DefaultAssetBundle.of(context).loadString('lib/utils/dota2.json');
  //starts at the <nameofprojectdirectory> level, in this case "ability_draft"
  //Then we go to lib/utils and then find the file.
  Map<String, dynamic> map = json.decode(data);
  List<String> oops = map.keys.toList();
  //REMOVE find better way to do
  oops.remove('target_dummy');
  return oops;
}

class HeroesAll extends StatelessWidget {
  const HeroesAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HeroesModel>(//Might get problems later
        builder: (BuildContext context, Widget child, HeroesModel model) {
      return Scaffold(
        body: Center(
          child: FutureBuilder<List<String>>(
            future: loadHeroNames(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                List<String>? temp = snapshot.data;
                return GridView.builder(
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.66,
                      crossAxisCount: 3,
                    ),
                    itemCount: temp!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _showHeroDetails(context, temp[index]);
                        },
                        child: Card(
                          color: Colors.indigo,
                          child: Stack(
                            children: <Widget>[
                              FadeInImage.assetNetwork(
                                placeholder: 'graphics/loading.gif',
                                image:
                                    'http://cdn.dota2.com/apps/dota2/images/heroes/${temp[index]}_lg.png',
                              ),
                              Center(child: Text(temp[index])),
                              //$LAZY$ VERISON, FIND A WAY TO WRITE THE PROPER HERO NAME
                            ],
                          ),
                        ),
                      );
                    });
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.next_plan, color: Colors.white),
            onPressed: () {
              //Switch to heroes all?
              // model.setStackIndex(0);
              //Create DB once
              initializeDB();
            }),
      );
    });
  }
}

initializeDB() {
  //if db exists init
}

_showHeroDetails(BuildContext context, String nameraw) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: const Text('help'),
      contentPadding: const EdgeInsets.all(9),
      children: [
        Text("more help $nameraw"),
      ],
    ),
  );
}

//205:115 <- ratio
String abc = 'http://cdn.dota2.com/apps/dota2/images/heroes/axe_lg.png';
/*
  ListView.builder(
                  itemCount: temp!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var heroName = temp[index];
                    return Column(
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 60,
                          color: Colors.indigo[(600 / (index + 1)).floor()],
                          child: FadeInImage.assetNetwork(
                            placeholder: 'graphics/loading.gif',
                            image:
                                'http://cdn.dota2.com/apps/dota2/images/heroes/${heroName}_lg.png',
                          ),
                        ),
                      ],
                    );
                  },
                ); 
 */

getAttributeColumn(var heroDetails) {
  return Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          const Icon(
            Icons.looks_one,
            color: Colors.red,
          ),
          RichText(
            text: TextSpan(
              text: heroDetails['base_str'].toString(),
              style: const TextStyle(color: Colors.white),
              children: <TextSpan>[
                TextSpan(
                  text: ' (+' +
                      heroDetails['str_gain'].toString() +
                      ' per level)',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          const Icon(
            Icons.looks_two,
            color: Colors.blue,
          ),
          RichText(
            text: TextSpan(
              text: heroDetails['base_int'].toString(),
              style: const TextStyle(color: Colors.white),
              children: <TextSpan>[
                TextSpan(
                  text: ' (+' +
                      heroDetails['int_gain'].toString() +
                      ' per level)',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          const Icon(
            Icons.looks_3,
            color: Colors.lightGreen,
          ),
          RichText(
            text: TextSpan(
              text: heroDetails['base_agi'].toString(),
              style: const TextStyle(color: Colors.white),
              children: <TextSpan>[
                TextSpan(
                  text: ' (+' +
                      heroDetails['agi_gain'].toString() +
                      ' per level)',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
