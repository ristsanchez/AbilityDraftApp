import 'package:ability_draft/Matches/ScoreboardScreen/ScoreboardBig.dart';
import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 203, 122),
      body: Center(
        child: Container(
          color: Colors.deepPurple,
          child: TextButton(
            onPressed: () {},
            child: Text('testScreen'),
          ),
        ),
      ),
    );
  }
}
