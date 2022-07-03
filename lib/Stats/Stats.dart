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
          getTopBarSearch(context),
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

getTopBarSearch(BuildContext context) {
  return Container(
    height: 50,
    child: clearContainerRect(
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  FontAwesomeIcons.arrowsRotate,
                  color: Colors.white38,
                ),
              ),
            ),
            const VerticalDivider(
              thickness: 2,
            ),
            Expanded(
              child: Center(
                child: TextField(
                  enableSuggestions: true,
                  onChanged: (value) {},
                  obscureText: false,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 15),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.white60,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    labelText: 'Search',
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              thickness: 2,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(
                FontAwesomeIcons.chevronDown,
                color: Colors.white38,
                size: 16,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
