import 'dart:ui';

import 'package:ability_draft/Matches/ScoreboardScreen/ScoreboardBig.dart';
import 'package:ability_draft/utils/idTable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

getOverall(BuildContext context, Map<String, dynamic> matchData) {
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 0, 15, 5),
    height: 260,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              width: 2,
              color: Colors.white.withOpacity(0.05),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getHeader(context, matchData['radiant_score'],
                  matchData['dire_score'], matchData['radiant_win']),
              getGroups(
                context,
                matchData['players'],
              ), // matchData['radiant_win']),
            ],
          ),
        ),
      ),
    ),
  );
}

getHeader(BuildContext context, int radiantScore, direScore, bool radiantWin) {
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
    width: MediaQuery.of(context).size.width,
    height: 30,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Score',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: radiantWin
                ? const FaIcon(
                    FontAwesomeIcons.crown,
                    color: Colors.yellow,
                    size: 14,
                  )
                : const Center(),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(
                FontAwesomeIcons.shieldHalved,
                color: Colors.lightGreen,
              ),
              Text(
                ' $radiantScore - $direScore ',
                style: const TextStyle(
                  color: Color.fromARGB(176, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const FaIcon(
                FontAwesomeIcons.shieldHalved,
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerLeft,
            child: !radiantWin
                ? const FaIcon(
                    FontAwesomeIcons.crown,
                    color: Colors.yellow,
                    size: 14,
                  )
                : const Center(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScoreboardBig()));
              },
              icon: const FaIcon(
                FontAwesomeIcons.upRightAndDownLeftFromCenter,
                color: Color.fromARGB(132, 255, 255, 255),
                size: 20,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

getMatchPlayersInfo(BuildContext context, List<dynamic> matchData) {
  final minInfo = <Map<String, dynamic>>[];
  Map<String, dynamic> temp = {};
  for (var element in matchData) {
    temp['net_worth'] = element['net_worth'];
    temp['kills'] = element['kills'];
    temp['assists'] = element['assists'];
    temp['deaths'] = element['deaths'];
    temp['hero_id'] = element['hero_id'];
    temp['isRadiant'] = element['isRadiant'];
    minInfo.add(temp);
    temp = {};
  }

  List<Map<String, dynamic>> dire = [];
  List<Map<String, dynamic>> radiant = [];
  minInfo.forEach((element) {
    if (element['isRadiant']) {
      radiant.add(element);
    } else {
      dire.add(element);
    }
  });

  Map<String, List<Map<String, dynamic>>> teams = {};
  teams['dire'] = dire;
  teams['radiant'] = radiant;
  return teams;
}

getGroups(BuildContext context, List<dynamic> matchData) {
  Map<String, List<Map<String, dynamic>>> teams =
      getMatchPlayersInfo(context, matchData);

  return Expanded(
    child: Row(
      children: [
        getGroup(
          context,
          teams['radiant'] ?? [],
          'Radiant',
        ),
        getGroup(
          context,
          teams['dire'] ?? [],
          'Dire',
        ),
      ],
    ),
  );
}

getGroup(
  BuildContext context,
  List<Map<String, dynamic>> team,
  String side,
) {
  var txtfi = <ClipRRect>[];
  team.forEach((hero) {
    return txtfi.add(getHeroMatchData(context, hero, side));
  });
  return Expanded(
    child: Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: (side == 'Radiant')
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Text(
                  side,
                  style: TextStyle(
                    color: (side == 'Radiant')
                        ? Colors.lightGreen
                        : Colors.redAccent,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          getHeroMatchDataHeader(),
          Column(
            children: txtfi,
          )
          // getHeroMatchDat2(context, boobie),
        ],
      ),
    ),
  );
}

getHeroMatchData(BuildContext context, Map<String, dynamic> hero, String side) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
        decoration: BoxDecoration(
          color: ((side == 'Radiant')
                  ? Colors.lightGreen
                  : const Color.fromARGB(255, 255, 94, 94))
              .withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          // border: Border.all(
          //   width: 2,
          //   color: Colors.white.withOpacity(0.1),
          // ),
        ),
        child: Row(
          // direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          // alignment: WrapAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 32,
              child: Image.asset(
                'assets/hero_icons_small/${getNameById(hero['hero_id'].toString())}.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  hero['kills'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(69, 255, 0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  hero['deaths'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    shadows: <Shadow>[
                      const Shadow(
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  hero['assists'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  hero['net_worth'].toString(),
                  style: const TextStyle(
                    color: Color.fromARGB(200, 255, 223, 0),
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

getHeroMatchDataHeader() {
  return Row(
    // direction: Axis.horizontal,
    crossAxisAlignment: CrossAxisAlignment.center,
    // alignment: WrapAlignment.spaceEvenly,
    children: const [
      SizedBox(
        width: 32,
      ),
      Expanded(
        flex: 1,
        child: Center(
          child: Text(
            'K',
            style: TextStyle(
              color: Color.fromARGB(200, 255, 255, 255),
              fontSize: 12,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Center(
          child: Text(
            'D',
            style: TextStyle(
              color: Color.fromARGB(200, 255, 255, 255),
              fontSize: 12,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Center(
          child: Text(
            'A',
            style: TextStyle(
              color: Color.fromARGB(200, 255, 255, 255),
              fontSize: 12,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Center(
          child: Text(
            'NET',
            style: TextStyle(
              color: Color.fromARGB(200, 255, 223, 0),
              fontSize: 12,
            ),
          ),
        ),
      ),
    ],
  );
}
