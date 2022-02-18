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
  return oops;
}

class HeroesHome extends StatelessWidget {
  const HeroesHome({Key? key}) : super(key: key);

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
                List<String>? temp = snapshot.data as List<String>?;
                temp!.sort();
                return ListView.builder(
                  itemCount: temp.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          //FIND A WAY TO MAKE TIS GROW ON ZOOM PINCH
                          //EG zoom in and out of table?
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              FadeInImage.assetNetwork(
                                placeholder: 'graphics/loading.gif',
                                image:
                                    'http://cdn.dota2.com/apps/dota2/images/heroes/${temp[index]}_lg.png',
                                //_lg.png or _sb.png or _vert.jpeg
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Center(child: Text('57%')),
                                  color: Colors.green,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Center(child: Text('37%')),
                                  color: Color.fromARGB(255, 126, 214, 75),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Center(child: Text('17%')),
                                  color: Colors.yellow,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Center(child: Text('7%')),
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 1),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.skip_previous, color: Colors.white),
            onPressed: () {
              //Switch to heroes all?
              model.setStackIndex(1);
              //Create DB once
            }),
      );
    });
  }
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
                                'http://cdn.dota2.com/apps/dota2/images/heroes/${temp[index]}_lg.png',
                          ),
                        ),
                      ],
                    );
                  },
                ); 
 */



/*
FadeInImage.assetNetwork(
placeholder: 'graphics/loading.gif',
image: 'http://cdn.dota2.com/apps/dota2/images/heroes/${}_lg.png',
),
*/

//LOW
//Method to map id to order alphabetically with their real name
//e.g. underlord has some weird name

//HIGH
//Methgod to map percentage to color range?, e.g. green to yellow to red