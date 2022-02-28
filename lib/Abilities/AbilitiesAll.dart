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

class AbilitiesAll extends StatelessWidget {
  const AbilitiesAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AbilitiesModel>(//Might get problems later
        builder: (BuildContext context, Widget child, AbilitiesModel model) {
      return Scaffold(
        body: Text('noway'),
        // _buildAllContents(context, model),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.gif_box_outlined, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.blueAccent,
                duration: Duration(seconds: 1),
                content: Text('Working'),
              ));

              // _populateDB(context);
            }),
      );
    });
  }
}

_buildAllContents(BuildContext context, AbilitiesModel model) {
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
              height: 120.0,
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
                      childAspectRatio: 1,
                      crossAxisCount: 5,
                    ),
                    itemCount: model.abis.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // _showHeroDialog(context, model.entryList[index]);
                        },
                        child: Stack(children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'http://cdn.dota2.com/apps/dota2/images/abilities/${model.abis[index].name}_lg.png',
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
                                  text: model.abis[index].id.toString(),
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

//$CHECK$Do this when the app is opened
_populateDB(BuildContext context) async {
  Map<String, dynamic> allHeroData;
  allHeroData = await loadAllHeroData(context);

  Map<String, dynamic> engData;
  engData = await loadEngData(context);

  Ability temp;
  Map<String, dynamic> spells;

  allHeroData.forEach((key, value) {
    spells = value['spells'];
    spells.forEach((k, v) async {
      if (k != 'generic_hidden') {
        temp = Ability.fromJson(
          v,
          k,
          v['properties'].toString(),
          json.encode(engData[key]),
        );
        await AbilitiesDBWorker.db.create(temp);
      }
    });
  });

  Scaffold.of(context).showSnackBar(const SnackBar(
    backgroundColor: Colors.green,
    duration: Duration(seconds: 3),
    content: Text('success'),
  ));
}
