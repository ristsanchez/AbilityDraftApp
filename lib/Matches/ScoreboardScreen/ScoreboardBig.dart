import 'package:flutter/material.dart';

class ScoreboardBig extends StatelessWidget {
  const ScoreboardBig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scoreboard'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          color: Colors.green,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Scoreboard'),
          ),
        ),
      ),
    );
  }
}
