import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe

//$LATE$ find widget that allows sorting values in columns

//$LATER$ hide heroes who are not available to be played in AD e.g. Meepo
//These wont have any steam data since they are unplayable in game

//Futurebuilder with steam data to build the list

class HeroesPercentages extends StatelessWidget {
  const HeroesPercentages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("all"),
    );
  }
}
//$LATER$
//Method to map id to order alphabetically with their real name
//e.g. underlord has some weird name

//$LATER$
//Methgod to map percentage to color range?, e.g. green to yellow to red



//6/21/22 reconstructing this particular screen after fixing steam api situation