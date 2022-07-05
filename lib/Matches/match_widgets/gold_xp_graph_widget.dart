import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:ability_draft/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

getGoldXpGraph(BuildContext context, var matchData, var other) {
  //min max lenght of matchData Array
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
    height: 255,
    child: clearContainer(
      Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
            height: 24,
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
                FaIcon(
                  FontAwesomeIcons.upRightAndDownLeftFromCenter,
                  color: Color.fromARGB(132, 255, 255, 255),
                  size: 14,
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.more_horiz_outlined,
                  color: Color.fromARGB(132, 255, 255, 255),
                  size: 24,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 200,
            child: Stack(
              children: [
                getGraphLabels(),
                LineChart(
                  mainData(matchData, other),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

getGraphLabels() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(35, 10, 0, 25),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors,
                ),
              ),
            ),
            const Text(
              ' Exp',
              style: TextStyle(
                  fontSize: 12, color: Color.fromARGB(153, 154, 255, 22)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5),
              width: 10,
              height: 10,
              color: goldColor,
            ),
            Text(
              ' Gold',
              style: TextStyle(
                color: goldColor.withOpacity(.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

List<Color> gradientColors = [
  const Color.fromARGB(255, 45, 240, 19),
  const Color.fromARGB(255, 245, 54, 54),
];

const Color goldColor = Color.fromARGB(255, 252, 203, 41);

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
          color: graphLineColor,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: graphLineColor,
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
          reservedSize: 30,
        ),
      ),
    ),
    borderData: FlBorderData(show: false),
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
        barWidth: 1.5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        aboveBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors:
                gradientColors.map((color) => color.withOpacity(0.4)).toList(),
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          cutOffY: 0,
          applyCutOffY: true,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors:
                gradientColors.map((color) => color.withOpacity(0.5)).toList(),
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          cutOffY: 0,
          applyCutOffY: true,
        ),
      ),
      LineChartBarData(
        color: goldColor,
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
    color: graphLegendColor,
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );
  String val = "";

  if (value % 10 == 0) {
    val = "${value ~/ 1}'";
  }
  Widget text = Text(
    val,
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
    color: graphLegendColor,
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );
  String text = '';
  if (value % 1000 == 0) {
    text = '${value ~/ 1000}k';
    if (value == 0) {
      text = '0';
    }
  }
  return Text(text, style: style, textAlign: TextAlign.right);
}

Widget rightTitleWidgets(double value, TitleMeta meta) {
  return const Text('');
}
