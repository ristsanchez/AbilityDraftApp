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

class AbilitiesHome extends StatelessWidget {
  const AbilitiesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AbilitiesModel>(//Might get problems later
        builder: (BuildContext context, Widget child, AbilitiesModel model) {
      return Scaffold(
        body: Text('imnotyourwankerboi'),
        //_buildAllContents(context, model),
        // floatingActionButton: FloatingActionButton(
        //     child: const Icon(Icons.gif_box_outlined, color: Colors.white),
        //     onPressed: () {
        //       Scaffold.of(context).showSnackBar(const SnackBar(
        //         backgroundColor: Colors.red,
        //         duration: Duration(seconds: 1),
        //         content: Text('Working'),
        //       ));

        //       // _populateDB(context);
        //     }),
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
              height: 60.0,
              alignment: Alignment.center,

              //get all from db, count it, display it as string
              child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.redAccent,
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
                          _showAbilityDialog(context, model.abis[index]);
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

Color? dom = Colors.grey[800];
Color? lig = Colors.grey[700];
_showAbilityDialog(BuildContext context, Ability ability) {
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
                            'http://cdn.dota2.com/apps/dota2/images/abilities/${ability.name}_lg.png',
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
                            text: ability.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: "primaryAtt(ability.primary_attr ?? " ")",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: "heroType(ability.type)",
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
                            text: '${ability.id} + ${ability.id}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: (ability.id == 0)
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
                            text: '${ability.id} + ${ability.id}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: (ability.id == 0)
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
                            text: '${ability.id} + ${ability.id}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: (ability.id == 0)
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: 'Move-speed: ${ability.id}',
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
                            text: ability.fmt!.substring(0, 10),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: ability.properties!.substring(0, 100),
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
