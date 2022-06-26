//pass: match data players array
//      make each hero xp/ gold pere minute array
//
import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

final List<Color> colores = [
  const Color(0xFF9E2EE9),
  const Color(0xFFe6194B),
  const Color(0xFFf58231),
  const Color(0xFFffe119),
  const Color(0xFFaaffc3),
  const Color(0xFFfabed4),
  const Color(0xFF3cb44b),
  const Color(0xFF42d4f4),
  const Color(0xFF4C71F5),
  const Color(0xFFf032e6),
];

getHeroXpGraph(BuildContext context, List<dynamic> xpLists) {
  List<LineChartBarData> lines = [];
  List<List> xpArs = [];
  List ids = [];
  //make each ar
  xpLists.forEach((heroPropMap) {
    ids.insert(0, heroPropMap['hero_id']);
    xpArs.insert(0, heroPropMap['xp_t']); //gold_t
  });

  int length = xpArs[0].length - 1;
  int maxXp = 60000;

  List<FlSpot> cur = [];
  for (var i = 0; i < 10; i++) {
    xpArs[i].forEach((e) {
      cur.insert(0, FlSpot((xpArs[i].indexOf(e)).toDouble(), e.toDouble()));
    });

    lines.insert(
      0,
      LineChartBarData(
        spots: cur,
        color: colores[i],
        isCurved: true,
        barWidth: .8,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
      ),
    );
    cur = [];
  }

  //min max lenght of matchData Array
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
              children: const [
                Expanded(
                  child: Text(
                    'Xp graph',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(Icons.more_horiz_outlined,
                    color: Color.fromRGBO(255, 255, 255, 0.655)),
                SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 180,
            child: LineChart(mainData(lines, length, maxXp)),
          ),
        ],
      ),
    ),
  );
}

LineChartData mainData(List<LineChartBarData> lines, int length, maxY) {
  // int max1 = xp.reduce((value, element) => value > element ? value : element);

  // int max = max0 > max1 ? max0 : max1;

  // int length = data.length;

  return LineChartData(
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
          interval: 10000,
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
    maxX: length.toDouble(),
    minY: 0,
    maxY: maxY.toDouble(),
    lineBarsData: lines,
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
