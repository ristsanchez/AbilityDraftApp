import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:ability_draft/matches/match_objects/index.dart';
import 'package:ability_draft/stats/stats.dart';
import 'package:flutter/material.dart';

class MatchInfo extends StatelessWidget {
  const MatchInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 8),
      width: MediaQuery.of(context).size.width,
      height: 104,
      child: clearContainer(
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // getHaeder(context),
            Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: getMatchLabels(context, temp)),
            getMatchLabels(context, temp),
          ],
        ),
      ),
    );
  }
}
