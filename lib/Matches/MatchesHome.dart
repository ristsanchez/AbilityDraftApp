import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:ability_draft/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:fl_chart/fl_chart.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';

import '../gameData/jsonUtil.dart';
import 'MatchModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/idTable.dart';
import '../utils/idTable.dart';

//$LATE$ find widget that allows sorting values in columns

//$LATER$ hide heroes who are not available to be played in AD e.g. Meepo
//These wont have any steam data since they are unplayable in game

//Futurebuilder with steam data to build the list

class MatchesHome extends StatelessWidget {
  const MatchesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MatchModel>(//Might get problems later
        builder: (BuildContext context, Widget child, MatchModel model) {
      return Scaffold(
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
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.next_plan, color: Colors.white),
            onPressed: () async {
              model.setStackIndex(1);
            }),
      );
    });
  }

  _buildMatchesContents(BuildContext context, Map<String, dynamic> matchData) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Container(
        color: Colors.black,
        child: Container(
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
                    getOverall(context, matchData),
                    getGoldXpGraph(context, matchData['radiant_gold_adv']),
                    getHeroesAbilityOrder(context, matchData['players']),
                  ],
                ),
              ),
              getTopBar(),
            ],
          ),
        ),
      );
    });
  }
}

getGoldXpGraph(BuildContext context, matchData) {
  //min max lenght of matchData Array
  return Container(
    height: 250,
    margin: EdgeInsets.all(15),
    child: Center(
      child: LineChart(mainData(matchData)),
    ),
    color: Color.fromARGB(57, 255, 255, 255),
  );
}

List<Color> gradientColors = [
  Color.fromARGB(255, 45, 240, 19),
  Color.fromARGB(255, 245, 54, 54),
];
List<Color> gradientColors2 = [
  Color.fromARGB(255, 236, 250, 38),
  Color.fromARGB(255, 212, 192, 6),
];
LineChartData mainData(List data) {
  int min = data.reduce((value, element) => value < element ? value : element);
  int max = data.reduce((value, element) => value > element ? value : element);
  int length = data.length;
  List<FlSpot> tenpy = [];

  for (int i = 0; i < length; i++) {
    tenpy.add(FlSpot((i).toDouble(), data[i].toDouble()));
    if (i == length - 1) {
      tenpy.add(FlSpot((i + 1).toDouble(), data[i].toDouble()));
    }
  }

  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Color.fromARGB(71, 55, 67, 77),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: Color.fromARGB(71, 55, 67, 77),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          getTitlesWidget: rightTitleWidgets,
        ),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          interval: 10,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1500,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 20,
        ),
      ),
    ),
    borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: length.toDouble(),
    minY: min.toDouble(),
    maxY: max.toDouble(),
    lineBarsData: [
      LineChartBarData(
        spots: tenpy,
        isCurved: false,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    ],
  );
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  Widget text = Text(
    '${value.toInt()}"',
    style: style,
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 0.0,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff67727d),
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  String text = '';
  if (value < 6001 && value > -6001) {
    text = '${value ~/ 1000}k';
  }

  return Text(text, style: style, textAlign: TextAlign.right);
}

Widget rightTitleWidgets(double value, TitleMeta meta) {
  return const Text('');
}

getHeroesAbilityOrder(BuildContext context, var statsList) {
  List<Widget> tempColumn = [];
  for (int i = 0; i < 10; i++) {
    tempColumn.add(
      getAbilitySequence(
        context,
        statsList[i]['ability_upgrades_arr'],
        statsList[i]['hero_id'],
        statsList[i]['isRadiant'],
      ),
    );
  }

  return Column(
    children: tempColumn,
  );
}

getAbilitySequence(BuildContext context, var aa, var hn, var boob) {
  List temp = aa;
  int heroname = hn;
  return Container(
    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
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
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                height: 36,
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Ability Build',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets/hero_icons_small/${getNameById(heroname.toString())}.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          (boob ? 'Radiant' : 'Dire'),
                          style: TextStyle(
                              color: boob ? Colors.red : Colors.lightGreen),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                height: (32 * 5),
                child: Stack(
                  children: [
                    GridView(
                      padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 1,
                      ),
                      children: getAbilityArray(temp),
                    ),
                    getAbilitiesColumn(context, temp),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

getAbilitiesColumn(BuildContext context, List abilitiesInOrder) {
  List uniqueList = abilitiesInOrder.toSet().toList();

  List<Widget> tempColumn = [];

  for (int i = 0; i < 5; i++) {
    tempColumn.add(makeImageContainer(context, uniqueList[i]));
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Column(
        children: tempColumn,
      ),
    ],
  );
}

makeImageContainer(BuildContext context, int id) {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(2),
      child: SizedBox(
        height: 28,
        width: 28,
        child: getImageFromFuture(context, id),
      ),
    ),
  );
}

getImageFromFuture(BuildContext context, int id) {
  return FutureBuilder(
    future: getAbilityNameById(context, id),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        return CachedNetworkImage(
          imageUrl:
              'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/${snapshot.data}.png',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(
            Icons.star,
            color: Colors.yellow,
          ),
        );
      } else if (snapshot.hasError) {
        return const Icon(
          Icons.error_outline,
          color: Colors.red,
        );
      } else {
        return const CircularProgressIndicator();
      }
    },
  );
}

getUniquenum(List upArr) {
  List uniqueElements = upArr.toSet().toList();
  return uniqueElements.length;
}

getAbilityArray(List upArr) {
  List uniqueElements = upArr.toSet().toList();

  // int rows = uniqueElements.length;

  int columns = upArr.length;

  List<Widget> tempColumn = [];

  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < 5; j++) {
      if (uniqueElements.indexOf(upArr[i]) == j) {
        tempColumn.add(nonEmptyBox(i, j));
      } else if (uniqueElements.indexOf(upArr[i]) > 4 && j == 4) {
        tempColumn.add(nonEmptyBox(i, 4));
      } else {
        tempColumn.add(emptyBox());
      }
    }
  }

  return tempColumn;
}

emptyBox() {
  return Center(
    child: Container(
      color: const Color.fromARGB(15, 255, 255, 255),
      margin: const EdgeInsets.all(1),
      height: 30,
      width: 30,
      child: const Center(),
    ),
  );
}

nonEmptyBox(var num, int colorIndex) {
  Color temp = Colors.black;
  switch (colorIndex) {
    case 0:
      temp = const Color.fromARGB(255, 54, 187, 248);
      break;
    case 1:
      temp = const Color.fromARGB(255, 3, 244, 164);
      break;

    case 2:
      temp = Colors.lightGreen;
      break;
    case 3:
      temp = const Color.fromARGB(255, 219, 255, 59);
      break;
    case 4:
      temp = Colors.orange;
      break;
    default:
  }

  return Center(
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: temp,
        ),
      ),
      margin: const EdgeInsets.all(1),
      height: 30,
      width: 30,
      child: Center(
        child: Text(
          '${num + 1}',
          style: TextStyle(color: temp),
        ),
      ),
    ),
  );
}

getOverall(BuildContext context, Map<String, dynamic> matchData) {
  return Container(
    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
    height: 320,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
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
              getHeader(context),
              getGroups(context, matchData['players']),
              getBottom(context),
              // getGroupPic2(context),
              //rows
            ],
          ),
        ),
      ),
    ),
  );
}

Future<Map<String, dynamic>> getMatchJson(BuildContext context) async {
  String data =
      await DefaultAssetBundle.of(context).loadString('lib/utils/match1.json');
  //starts at the <nameofprojectdirectory> level, in this case "ability_draft"
  //Then we go to lib/utils and then find the file.
  Map<String, dynamic> map = json.decode(data);
  return map;
}

getTopBar() {
  return Column(
    children: [
      Container(
        height: 27.0,
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 0, 0, 0),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 55.0,
        alignment: Alignment.center,
        color: const Color.fromARGB(129, 0, 0, 0),
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
    ],
  );
}

getHeader(BuildContext context) {
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const FaIcon(
                FontAwesomeIcons.shieldHalved,
                color: Colors.lightGreen,
              ),
              const Text(
                ' 32 - 12 ',
                style: TextStyle(
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
          child: Container(),
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
        getGroup(context, teams['radiant'] ?? [], 'Radiant'),
        getGroup(context, teams['dire'] ?? [], 'Dire'),
      ],
    ),
  );
}

getGroup(BuildContext context, List<Map<String, dynamic>> team, String side) {
  var txtfi = <ClipRRect>[];
  team.forEach((hero) {
    return txtfi.add(getHeroMatchData(context, hero));
  });
  return Expanded(
    child: Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: (side == 'Radiant')
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.center,
              children: [
                Text(
                  side,
                  style: TextStyle(
                    color: (side == 'Radiant')
                        ? Colors.lightGreen
                        : Colors.redAccent,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
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

getHeroMatchData(BuildContext context, Map<String, dynamic> hero) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
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

getBottom(BuildContext context) {
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
    width: MediaQuery.of(context).size.width,
    height: 30,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Match Id: 10932874',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(125, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const FaIcon(
                FontAwesomeIcons.upRightAndDownLeftFromCenter,
                color: Color.fromARGB(132, 255, 255, 255),
              ),
              const SizedBox(
                width: 25,
              ),
              const FaIcon(
                FontAwesomeIcons.share,
                color: Color.fromARGB(132, 255, 255, 255),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

getGroupPic(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    width: MediaQuery.of(context).size.width,
    height: 75,
    color: Colors.grey,
    child: Stack(
      children: <Widget>[
        Positioned(
          left: -15,
          child: SizedBox(
            width: 120,
            height: 75,
            child: getCachedImageWidget('antimage'),
          ),
        ),
        Positioned(
          left: 50,
          child: SizedBox(
            width: 120,
            height: 75,
            child: getCachedImageWidget('invoker'),
          ),
        ),
        Positioned(
          left: 110,
          child: SizedBox(
            width: 120,
            height: 75,
            child: getCachedImageWidget('storm_spirit'),
          ),
        ),
        Positioned(
          left: 175,
          child: SizedBox(
            width: 120,
            height: 75,
            child: getCachedImageWidget('axe'),
          ),
        ),
        Positioned(
          right: 0,
          child: SizedBox(
            width: 120,
            height: 75,
            child: getCachedImageWidget('pudge'),
          ),
        ),
      ],
    ),
  );
}

getGroupPic2(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 75,
    color: Colors.grey,
    child: Stack(
      children: <Widget>[
        Positioned(
          left: -15,
          child: SizedBox(
            width: 120,
            height: 75,
            child: getCachedImageWidget('furion'),
          ),
        ),
        Positioned(
          left: 50,
          child: SizedBox(
            width: 120,
            height: 75,
            child: getCachedImageWidget('clinkz'),
          ),
        ),
        Positioned(
          left: 110,
          child: SizedBox(
            width: 120,
            height: 75,
            child: getCachedImageWidget('omniknight'),
          ),
        ),
        Positioned(
          left: 175,
          child: SizedBox(
            width: 120,
            height: 75,
            child: getCachedImageWidget('dark_seer'),
          ),
        ),
        Positioned(
          right: 0,
          child: SizedBox(
            width: 120,
            height: 75,
            child: getCachedImageWidget('juggernaut'),
          ),
        ),
      ],
    ),
  );
}

getCachedImageWidget(String name) {
  return CachedNetworkImage(
    imageUrl:
        'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/crops/$name.png',
    placeholder: (context, url) => const CircularProgressIndicator(),
    errorWidget: (context, url, error) => const Icon(Icons.fire_hydrant),
  );
}
/*
SizedBox(
                        width: 300,
                        height: 200,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 0,
                              child: SizedBox(
                                width: 160,
                                height: 100,
                                child: getCachedImageWidget('puck'),
                              ),
                            ),
                            Positioned(
                              left: 50,
                              child: SizedBox(
                                width: 160,
                                height: 100,
                                child: getCachedImageWidget('axe'),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: SizedBox(
                                width: 160,
                                height: 100,
                                child: getCachedImageWidget('pudge'),
                              ),
                            ),
                          ],
                        ),
                      ),
*/
