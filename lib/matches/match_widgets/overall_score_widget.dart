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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getHeader(context, matchData),
          getSubheader(context, matchData),
          getGroups(
            context,
            matchData.playerList,
          ), // matchData['radiant_win']),
        ],
      ),
    ),
  );
}

getSubheader(BuildContext context, MatchEntry matchData) {
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
    width: MediaQuery.of(context).size.width,
    height: 30,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: matchData.radiantWin
                    ? const FaIcon(
                        FontAwesomeIcons.crown,
                        color: Colors.yellow,
                        size: 14,
                      )
                    : const Center(),
              ),
              const Text(
                'Radiant',
                style: TextStyle(
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(
                FontAwesomeIcons.fireFlameCurved,
                color: Colors.lightGreen,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  '${matchData.radiantScore} - ${matchData.direScore}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const FaIcon(
                FontAwesomeIcons.droplet,
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Dire',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  )),
              Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: !matchData.radiantWin
                    ? const FaIcon(
                        FontAwesomeIcons.crown,
                        color: Colors.yellow,
                        size: 14,
                      )
                    : const Center(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

getHeader(BuildContext context, MatchEntry matchData) {
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
    width: MediaQuery.of(context).size.width,
    height: 30,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Text(
            'Overview',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 8),
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
              size: 14,
            ),
          ),
        ),
        const Icon(
          Icons.more_horiz_outlined,
          color: Color.fromARGB(132, 255, 255, 255),
          size: 24,
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
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
      child: Column(
        children: [
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
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
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
    ),
  );
}

getHeroMatchDataHeader() {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        SizedBox(
          width: 30,
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'K',
              style: TextStyle(
                color: Color.fromARGB(200, 255, 255, 255),
                fontSize: 10,
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
                fontSize: 10,
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
                fontSize: 10,
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
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
