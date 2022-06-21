import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

getGoldXpGraph(BuildContext context, var matchData, var other) {
  //min max lenght of matchData Array
  return Container(
    margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
    height: 256,
    child: clearContainer(
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
                            const Expanded(
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