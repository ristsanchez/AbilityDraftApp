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
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Text(error.toString()),
              ),
            ),
            Expanded(
              // A flexible child that will grow to fit the viewport but
              // still be at least as big as necessary to fit its contents.
              child: Container(
                color: Colors.white, // Red
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
                          _tempCreateStats(model, context);
                        },
                        child: Card(
                          color: Colors.indigo,
                          child: Stack(children: <Widget>[
                            CachedNetworkImage(
                              imageUrl:
                                  'http://cdn.dota2.com/apps/dota2/images/heroes/${model.entryList[index].base_name}_lg.png',
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              //$LATER$ make sure progess indicator appears centered and right size
                              errorWidget: (context, url, error) =>
                                  Text(error.toString()),
                            ),
                            Center(
                              child:
                                  Text(model.entryList[index].name ?? "empty"),
                            ),
                            //$LAZY$ VERISON, FIND A WAY TO WRITE THE PROPER HERO NAME
                          ]),
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

_tempCreateStats(HeroesModel model, BuildContext context) {
  // List<AHero> temst = [];
  // temst = await HeroesDBWorker.db.getAll();

  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.green,
    duration: Duration(seconds: 1),
    content: Text(model.entryList.length.toString()),
  ));
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
