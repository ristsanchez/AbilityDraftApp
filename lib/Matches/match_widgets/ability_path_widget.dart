import 'dart:ui';

import 'package:ability_draft/gameData/jsonUtil.dart';
import 'package:ability_draft/utils/idTable.dart';
import 'package:flutter/material.dart';

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
          return Image.asset('assets/ability_images/${snapshot.data}.png');
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
