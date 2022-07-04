import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:ability_draft/constants/colors.dart';
import 'package:ability_draft/matches/match_providers/index_provider.dart';
import 'package:ability_draft/matches/match_widgets/hero_xp_graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_switch/flutter_switch.dart';

getHeroGoldGraph(BuildContext context, List<dynamic> playerData) {
  bool showXp = Provider.of<IndexChangeProvider>(context, listen: true).show;
  List<Widget> graphs = [
    _heroGoldXpGraph(context, playerData, true),
    _heroGoldXpGraph(context, playerData, false)
  ];

  return Container(
    margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
    height: 236,
    child: clearContainerUnclipped(
      Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            height: 50,
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Gold/Xp graph',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Switch(
                  value: showXp,
                  onChanged: (bool newval) {
                    Provider.of<IndexChangeProvider>(context, listen: false)
                        .toggleSwitch(newval);

                    //call provider setnew thing
                  },
                ),
                const Icon(Icons.more_horiz_outlined,
                    color: Color.fromRGBO(255, 255, 255, 0.655)),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 180,
            child: showXp ? graphs[0] : graphs[1],
          ),
        ],
      ),
    ),
  );
}

//Graph methods
//-----------------------------------------------------------------------------
LineChart _heroGoldXpGraph(
    BuildContext context, List<dynamic> xpLists, bool isxp) {
  int max = 0;
  List<LineChartBarData> lines = [];
  List<List> heroDataList = [];
  List ids = [];
  List tmp;

  xpLists.forEach((heroPropMap) {
    ids.insert(0, heroPropMap['hero_id']);
    tmp = isxp ? heroPropMap['xp_t'] : heroPropMap['gold_t'];
    heroDataList.insert(0, tmp);

    if (max < tmp.last) {
      max = tmp.last;
    }
  });

  int length = heroDataList[0].length - 1;

  List<FlSpot> cur = [];
  for (var i = 0; i < 10; i++) {
    heroDataList[i].forEach((e) {
      cur.insert(
          0, FlSpot((heroDataList[i].indexOf(e)).toDouble(), e.toDouble()));
    });

    lines.insert(0, _getLinesData(cur, i));
    cur = [];
  }

  //min max lenght of matchData Array
  return LineChart(_mainData(lines, length, max));
}

LineChartBarData _getLinesData(List<FlSpot> cur, int index) {
  return LineChartBarData(
    spots: cur,
    color: heroGraphColors[index],
    isCurved: true,
    barWidth: .8,
    isStrokeCapRound: true,
    dotData: FlDotData(
      show: false,
    ),
  );
}

LineChartData _mainData(List<LineChartBarData> lines, int length, int maxY) {
  return LineChartData(
    lineBarsData: lines,
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 10000,
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
          interval: 100000,
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
          getTitlesWidget: _bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 10000,
          getTitlesWidget: _leftTitleWidgets,
          reservedSize: 25,
        ),
      ),
    ),
    borderData: FlBorderData(show: false),
    minX: 0,
    maxX: length.toDouble(),
    minY: 0,
    maxY: maxY.toDouble(),
  );
}

SideTitleWidget _bottomTitleWidgets(double value, TitleMeta meta) {
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

Widget _leftTitleWidgets(double value, TitleMeta meta) {
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
//-----------------------------------------------------------------------------
