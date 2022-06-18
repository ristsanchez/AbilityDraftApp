import 'dart:convert';
import 'dart:ui';

import 'package:ability_draft/Matches/MatchData/match_entry.dart';
import 'package:ability_draft/Matches/MatchesWidgets/OverallScoreWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:scoped_model/scoped_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../gameData/jsonUtil.dart';
import 'MatchModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                    getCarousel(),
                    getOverall(context, MatchEntry.fromJson(matchData)),
                    getGoldXpGraph(
                      context,
                      matchData['radiant_gold_adv'],
                      matchData['radiant_xp_adv'],
                    ),
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

// artus? espiritu
// Vladick

final List<String> imgList = [
  'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/axe.png',
  'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/wisp.png',
  'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/lina.png',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${imgList.indexOf(item)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

getCarousel() {
  return Container(
    child: CarouselSlider(
      options: CarouselOptions(
        padEnds: true,
        viewportFraction: .6,
        autoPlay: true,
        aspectRatio: 1.78,
        enlargeCenterPage: true,
      ),
      items: imageSliders,
    ),
    color: Colors.black,
    height: 140,
  );
}

getGoldXpGraph(BuildContext context, var matchData, var other) {
  //min max lenght of matchData Array
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
    height: 256,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.white.withOpacity(0.15),
            border: Border.all(
              width: 2,
              color: Colors.white.withOpacity(0.05),
            ),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                height: 50,
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Team Advantages',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.more_horiz_outlined,
                      color: Color.fromARGB(167, 255, 255, 255),
                    ),
                    SizedBox(
                      width: 15,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: 200,
                child: Stack(
                  children: [
                    LineChart(
                      mainData(matchData, other),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(27, 0, 0, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 10,
                                    color: Color.fromARGB(223, 255, 255, 255),
                                  ),
                                ),
                                const Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Gold',
                                    style: TextStyle(
                                      color: Color.fromARGB(155, 255, 255, 255),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color.fromARGB(169, 45, 240, 19),
                                            Color.fromARGB(171, 245, 54, 54),
                                          ]),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Exp',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(137, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
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

List<Color> gradientColors = [
  const Color.fromARGB(255, 45, 240, 19),
  const Color.fromARGB(255, 245, 54, 54),
];
List<Color> gradientColors2 = [
  const Color.fromARGB(255, 236, 250, 38),
  const Color.fromARGB(255, 212, 192, 6),
];

LineChartData mainData(List data, List xp) {
  int min0 = data.reduce((value, element) => value < element ? value : element);
  int max0 = data.reduce((value, element) => value > element ? value : element);

  int min1 = xp.reduce((value, element) => value < element ? value : element);
  int max1 = xp.reduce((value, element) => value > element ? value : element);

  int min = min0 < min1 ? min0 : min1;
  int max = max0 > max1 ? max0 : max1;

  int length = data.length;
  List<FlSpot> goldPerMin = [];
  List<FlSpot> expPerMin = [];

  for (int i = 0; i < length; i++) {
    goldPerMin.add(FlSpot((i).toDouble(), data[i].toDouble()));
    expPerMin.add(FlSpot((i).toDouble(), xp[i].toDouble()));
  }

  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 5000,
      verticalInterval: 10,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color.fromARGB(60, 255, 255, 255),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color.fromARGB(60, 255, 255, 255),
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
          interval: 5000,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 25,
        ),
      ),
    ),
    borderData: FlBorderData(
        show: false,
        border:
            Border.all(color: const Color.fromARGB(82, 217, 255, 0), width: 1)),
    minX: 0,
    maxX: (length - 1).toDouble(),
    minY: (min - 500).toDouble(),
    maxY: (max + 500).toDouble(),
    lineBarsData: [
      LineChartBarData(
        spots: expPerMin,
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        barWidth: 3.5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors:
                gradientColors.map((color) => color.withOpacity(0.15)).toList(),
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      LineChartBarData(
        color: const Color.fromARGB(255, 255, 255, 255),
        spots: goldPerMin,
        isCurved: true,
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
      ),
    ],
  );
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 10,
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
    fontSize: 10,
  );
  String text = '';
  if (value % 1000 == 0) {
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

getAbilitySequence(
    BuildContext context, List abilityList, int heroname, bool isTeamRadiant) {
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
                          (isTeamRadiant ? 'Radiant' : 'Dire'),
                          style: TextStyle(
                            color:
                                isTeamRadiant ? Colors.lightGreen : Colors.red,
                          ),
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
                      children: getAbilityArray(abilityList),
                    ),
                    getAbilitiesColumn(context, abilityList),
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
        String name = snapshot.data.toString();
        if (!name.startsWith('special')) {
          return CachedNetworkImage(
            imageUrl:
                'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/${snapshot.data}.png',
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
          );
        }
        return const Icon(
          Icons.star,
          color: Color.fromARGB(255, 219, 200, 23),
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
      temp = Color.fromARGB(255, 54, 248, 206);
      break;

    case 2:
      temp = Color.fromARGB(255, 54, 248, 70);
      break;
    case 3:
      temp = Color.fromARGB(255, 196, 248, 54);
      break;
    case 4:
      temp = Color.fromARGB(255, 251, 255, 0);
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
            children: const [
              Text(
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

getCachedImageWidget(String name) {
  return CachedNetworkImage(
    imageUrl:
        'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/crops/$name.png',
    placeholder: (context, url) => const CircularProgressIndicator(),
    errorWidget: (context, url, error) => const Icon(Icons.fire_hydrant),
  );
}
