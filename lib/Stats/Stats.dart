import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:ability_draft/Stats/steam_login_webview.dart';
import 'package:ability_draft/matches/match_objects/index.dart';
import 'package:ability_draft/stats/stats_provider.dart';
import 'package:ability_draft/utility_futures/json_utils.dart';
import 'package:ability_draft/utility_time/time_utils.dart';
import 'package:ability_draft/utils/idTable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: FutureBuilder(
          future: getTestMatchInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getMatchEntriesHeaders(context),
                    getMatchEntry(context, snapshot.data),
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

getMatchEntriesHeaders(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: ListTile(
      trailing: Icon(
        Icons.abc,
        color: Color.fromARGB(0, 0, 0, 0),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Match Id'),
          Text('Game Mode'),
          Text('Result'),
        ],
      ),
    ),
  );
}

//scrollable row/listview

getMatchEntry(BuildContext context, MatchEntry match) {
  return ExpansionTile(
    textColor: Colors.white,
    title: getLabels(context, match),
    children: [
      getTeamImageRow(context, match.getRadiantPlayers()),
      getTeamImageRow(context, match.getDirePlayers()),
    ],
  );
}

getLabels(BuildContext context, MatchEntry match) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              match.matchId.toString(),
              style: TextStyle(color: Colors.blue),
            ),
            Text('3 minutes ago')
          ],
        ), //MatchID

        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Single Draft'), Text('Ranked')]), //GAMEMODE
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Radiant vict',
            style: TextStyle(color: Colors.red),
          ),
          Text('37:52')
        ]), //REsult/duration
      ],
    ),
  );
}

getTeamImageRow(BuildContext context, List<Player> playerList) {
  List<Widget> list = [];
  playerList.forEach((player) {
    list.add(
      Image.asset(
        'assets/hero_portraits_big/${getNameById(player.heroId)}.png',
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width / 5,
      ),
    );
  });

  return SizedBox(
    child: Row(
      children: list,
      mainAxisAlignment: MainAxisAlignment.center,
    ),
  );
}
