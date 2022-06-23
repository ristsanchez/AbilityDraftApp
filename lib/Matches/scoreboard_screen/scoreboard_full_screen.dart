import '../match_objects/index.dart';
import 'package:ability_draft/utils/idTable.dart';
import 'package:flutter/material.dart';

class ScoreboardBig extends StatelessWidget {
  final MatchEntry matchData;
  const ScoreboardBig({
    Key? key,
    required this.matchData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: getScoreboard(matchData.playerList)),
            ],
          ),
        ),
      ),
    );
  }
}

getScoreboard(List<Player> playerList) {
  List<Widget> sbWidgetList = [];

  for (Player each in playerList) {
    if (each.isRadiant) {
      sbWidgetList.insert(0, rowMaker(each));
    } else {
      sbWidgetList.insert(sbWidgetList.length - 1, rowMaker(each));
    }
  }

  sbWidgetList.insert(0, getHeroMatchDataHeader(true));
  sbWidgetList.insert(6, getHeroMatchDataHeader(false));
  sbWidgetList.insert(0, SizedBox(height: 5));
  return sbWidgetList;
}

getHeroMatchDataHeader(bool isRadiant) {
  return Container(
    height: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          width: 85,
          child: Text(
            isRadiant ? 'Radiant' : 'Dire',
            style: TextStyle(
              color: isRadiant ? Colors.green : Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(width: 60),
        colChar('K'),
        colChar('D'),
        colChar('A'),
        colChar('NET',
            special: true, width: 50), //after this: itemsbackpackbuffs
        colChar('LH'),
        colChar('/', width: 10),
        colChar('DN'),
        colChar('GPM', special: true, width: 50),
        colChar('XPM', width: 40),
        colChar('DMG', width: 50),
        colChar('HEAL', width: 50),
        colChar('BLD', width: 50),
        const SizedBox(
          width: 60,
        )
      ],
    ),
  );
}

//Makes a container with the according column name, size and color
colChar(String name, {bool special = false, int width = 30}) {
  return Container(
    alignment: Alignment.center,
    width: width.toDouble(),
    child: Text(
      name,
      style: TextStyle(
        color: !special
            ? const Color.fromARGB(200, 255, 255, 255)
            : const Color.fromARGB(200, 255, 223, 0),
        fontSize: 16,
      ),
    ),
  );
}

rowMaker(Player player) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
    color: const Color.fromARGB(30, 255, 255, 255),
    child: Row(
      // direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.start,
      // alignment: WrapAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/hero_portraits_big/${getNameById(player.heroId.toString())}.png',
          fit: BoxFit.fill,
          width: 85,
        ),
        Container(
          alignment: Alignment.center,
          width: 60,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  width: 2, color: const Color.fromARGB(255, 212, 184, 55)),
            ),
            child: Center(
                child: Text(
              '27',
              style: TextStyle(
                  color: Color.fromARGB(255, 212, 184, 55), fontSize: 12),
            )),
          ),
        ),
        colEntry(player.kills),
        colEntry(player.deaths),
        colEntry(player.assists),
        colEntry(player.netWorth, special: true, width: 50),
        colEntry(player.lastHits),
        colChar('/', width: 10),
        colEntry(player.denies),
        colEntry(player.goldPerMin, special: true, width: 50),
        colEntry(player.xpPerMin, width: 40),
        colEntry(player.heroDamage, width: 50),
        colEntry(player.heroHealing, width: 50),
        colEntry(player.towerDamage, width: 50),
        const SizedBox(
          width: 32,
        )
      ],
    ),
  );
}

colEntry(int val, {bool special = false, int width = 30}) {
  return Container(
    alignment: Alignment.center,
    width: width.toDouble(),
    height: 40,
    child: Text(
      val.toString(),
      style: TextStyle(
        color: !special
            ? const Color.fromARGB(200, 255, 255, 255)
            : const Color.fromARGB(200, 255, 223, 0),
        fontSize: 16,
      ),
    ),
  );
}
