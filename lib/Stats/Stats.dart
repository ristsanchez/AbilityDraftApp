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
      body: Stack(
        children: <Widget>[
          buildList(context),
          getTopBarSearch(context),
        ],
      ),
    );
  }
}

buildList(BuildContext context) {
  //list from prov

  Provider.of<StatsProvider>(context).initList();
  List<MatchEntry> mlist = [];
  mlist = Provider.of<StatsProvider>(context, listen: true).list;

  return mlist.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : ListView.builder(
          padding: const EdgeInsets.only(top: 55),
          itemCount: mlist.length,
          itemBuilder: (BuildContext context, int index) {
            return getMatchEntry(context, mlist[index], index == 0);
          },
        );
}

getMatchEntriesHeaders(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: ListTile(
      trailing: const Icon(
        Icons.abc,
        color: Color.fromARGB(0, 0, 0, 0),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text('Match Id'),
          Text('Game Mode'),
          Text('Result'),
        ],
      ),
    ),
  );
}

//scrollable row/listview

getMatchEntry(BuildContext context, MatchEntry match, bool showHeroes) {
  return ExpansionTile(
    initiallyExpanded: showHeroes,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                match.matchId.toString(),
                style: const TextStyle(color: Colors.blue),
              ),
              Text(
                getTimeAgoEpoch(match.start_time + match.duration),
                style: TextStyle(color: Colors.white60),
              )
            ],
          ),
        ), //MatchID

        Expanded(
          flex: 1,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Single Draft'),
                Text(
                  'Ranked',
                  style: TextStyle(color: Colors.white60),
                )
              ]),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    match.radiantWin ? 'Radiant ' : 'Dire ',
                    style: TextStyle(
                      color: match.radiantWin ? Colors.lightGreen : Colors.red,
                    ),
                  ),
                  const FaIcon(
                    FontAwesomeIcons.crown,
                    color: Colors.yellow,
                    size: 14,
                  ),
                ],
              ),
              Text(
                getMinFromSecsForm(match.duration),
                style: const TextStyle(color: Colors.white60),
              ),
            ],
          ),
        ),
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
        width: (MediaQuery.of(context).size.width - 20) / 5,
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
