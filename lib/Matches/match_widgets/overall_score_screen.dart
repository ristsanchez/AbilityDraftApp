import 'dart:ui';
import '../match_objects/index.dart';

import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:ability_draft/utils/idTable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../scoreboard_screen/scoreboard_full_screen.dart';

getOverall(BuildContext context, MatchEntry matchData) {
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 0, 15, 5),
    height: 260,
    child: clearContainer(
      Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getHeader(context, matchData),
          getGroups(
            context,
            matchData.playerList,
          ), // matchData['radiant_win']),
        ],
      ),
    ),
  );
}

getHeader(BuildContext context, MatchEntry matchData) {
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
            child: matchData.radiantWin
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
                ' ${matchData.radiantScore} - ${matchData.direScore} ',
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
            child: !matchData.radiantWin
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
                    builder: (context) => ScoreboardBig(
                      matchData: matchData,
                    ),
                  ),
                );
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

getTeamsMap(BuildContext context, List<Player> playerList) {
  List<Player> dire = [];
  List<Player> radiant = [];

  for (Player player in playerList) {
    if (player.isRadiant) {
      radiant.add(player);
    } else {
      dire.add(player);
    }
  }

  Map<String, List<Player>> teams = {};
  teams['dire'] = dire;
  teams['radiant'] = radiant;
  return teams;
}

getGroups(BuildContext context, List<Player> matchData) {
  Map<String, List<Player>> teams = getTeamsMap(context, matchData);

  return Expanded(
    child: Row(
      children: [
        getGroup(
          context,
          teams['radiant'] ?? [],
          true,
        ),
        getGroup(
          context,
          teams['dire'] ?? [],
          false,
        ),
      ],
    ),
  );
}

getGroup(BuildContext context, List<Player> team, bool isRadiant) {
  var groupArea = <ClipRRect>[];

  for (Player player in team) {
    groupArea.add(getHeroMatchData(context, player, isRadiant));
  }

  return Expanded(
    child: Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment:
                  isRadiant ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Text(
                  isRadiant ? 'Radiant' : 'Dire',
                  style: TextStyle(
                    color: isRadiant ? Colors.lightGreen : Colors.redAccent,
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
            children: groupArea,
          )
          // getHeroMatchDat2(context, boobie),
        ],
      ),
    ),
  );
}

getHeroMatchData(BuildContext context, Player player, bool isRadiant) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
        decoration: BoxDecoration(
          color: (isRadiant
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
                'assets/hero_icons_small/${getNameById(player.heroId)}.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  player.kills.toString(),
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
                  player.deaths.toString(),
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
              flex: 1,
              child: Center(
                child: Text(
                  player.assists.toString(),
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
                  player.netWorth.toString(),
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
