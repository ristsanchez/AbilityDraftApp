import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

import 'HeroesModel.dart';

//$LATE$ find widget that allows sorting values in columns

//$LATER$ hide heroes who are not available to be played in AD e.g. Meepo
//These wont have any steam data since they are unplayable in game

//Futurebuilder with steam data to build the list

class HeroesHome extends StatelessWidget {
  const HeroesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HeroesModel>(//Might get problems later
        builder: (BuildContext context, Widget child, HeroesModel model) {
      return Scaffold(
        body: _buildHomeContents(context, model),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.skip_previous, color: Colors.white),
            onPressed: () {
              //Switch to heroes all?
              model.setStackIndex(0);
              //Create DB once
            }),
      );
    });
  }
}

_buildHomeContents(BuildContext context, HeroesModel model) {
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
              height: 60.0,
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
                child: Center(
                  //$LATER$ populate hero list on new install
                  child: (model.entryList.isEmpty)
                      ? const Center(
                          child: Text('sorry'),
                        )
                      : ListView.builder(
                          itemCount: model.entryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                  //FIND A WAY TO MAKE TIS GROW ON ZOOM PINCH
                                  //EG zoom in and out of table?
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        //$LATER$ shirnkwrap the image
                                        child: Container(
                                          color: Colors.black,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'http://cdn.dota2.com/apps/dota2/images/heroes/${model.entryList[index].base_name}_lg.png',
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Text(error.toString()),
                                          ),
                                        ),
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
                                          color:
                                              Color.fromARGB(255, 126, 214, 75),
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
                        ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  });
}


//$LATER$
//Method to map id to order alphabetically with their real name
//e.g. underlord has some weird name

//$LATER$
//Methgod to map percentage to color range?, e.g. green to yellow to red