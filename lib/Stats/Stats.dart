import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
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
