import 'dart:convert';

import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:ability_draft/matches/match_widgets/hero_gold_graph.dart';
import 'package:ability_draft/matches/match_widgets/hero_xp_graph.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'match_widgets/index.dart';
import 'match_objects/index.dart';

//$LATE$ find widget that allows sorting values in columns

//$LATER$ hide heroes who are not available to be played in AD e.g. Meepo
//These wont have any steam data since they are unplayable in game

//Futurebuilder with steam data to build the list

class MatchesHome extends StatelessWidget {
  const MatchesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
          child: FutureBuilder(
        future: getMatchJson(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            return _buildMatchesContents(context, snapshot.data);
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
            children = <Widget>[
              const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              const Padding(
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

  _buildMatchesContents(BuildContext context, Map<String, dynamic> matchData) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Container(
        alignment: Alignment.topCenter,
        child: Stack(
          children: <Widget>[
            Scrollbar(
              thickness: 2,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  getCarousel(),
                  getOverall(context, MatchEntry.fromJson(matchData)),
                  getGoldXpGraph(
                    context,
                    matchData['radiant_gold_adv'],
                    matchData['radiant_xp_adv'],
                  ),
                  getHeroGoldGraph(context, matchData['players']),
                  getHeroesAbilityOrder(context, matchData['players']),
                ],
              ),
            ),
            getTopBar(),
          ],
        ),
      );
    });
  }
}

// artus? espiritu
// Vladick

Future<Map<String, dynamic>> getMatchJson(BuildContext context) async {
  //starts at the <nameofprojectdirectory> level, in this case "ability_draft"
  //Then we go to lib/utils and then find the file.
  String data =
      await DefaultAssetBundle.of(context).loadString('lib/utils/match1.json');

  Map<String, dynamic> map = json.decode(data);
  return map;
}

getTopBar() {
  return Column(
    children: [
      clearContainerRect(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 52.0,
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: const FaIcon(
                    FontAwesomeIcons.circleChevronLeft,
                    color: Color.fromARGB(123, 255, 255, 255),
                  ),
                ),
              ),
              const Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    'Ranked - 06/29/20',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    FaIcon(
                      FontAwesomeIcons.circleChevronRight,
                      color: const Color.fromARGB(123, 255, 255, 255),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: const Color.fromARGB(123, 255, 255, 255),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
