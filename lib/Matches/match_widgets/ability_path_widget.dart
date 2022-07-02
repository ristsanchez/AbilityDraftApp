import 'dart:ui';

import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:ability_draft/gameData/jsonUtil.dart';
import 'package:ability_draft/utils/idTable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../match_providers/ability_path_provider.dart';

getHeroesAbilityOrder(BuildContext context, List<dynamic> statsList) {
  List<Widget> tempColumn = [];
  List<Widget> iconsRow = [];
  for (int i = 0; i < 10; i++) {
    iconsRow.add(getElevatedButton(
      context,
      getNameById(statsList[i]['hero_id']),
      i,
    ));
    tempColumn.add(
      getAbilitySequence(
        context,
        statsList[i]['ability_upgrades_arr'],
        statsList[i]['hero_id'],
        statsList[i]['isRadiant'],
      ),
    );
  }

  //return list of icons to be cliccked
  // anddd current tab?
  int currentIndex =
      Provider.of<AbilityPathProvider>(context, listen: true).index;

  return Padding(
    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
    child: clearContainer(
      Column(
        children: [
          getHeaderRow(context),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Row(children: iconsRow),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: tempColumn[currentIndex],
          ),
        ],
      ),
    ),
  );
}

getHeaderRow(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Ability upgrades',
          style: Theme.of(context).textTheme.headline6,
        ),
        const Icon(
          Icons.more_horiz,
          color: Colors.white60,
        ),
      ],
    ),
  );
}

getElevatedButton(BuildContext context, String heroIconName, int index) {
  return GestureDetector(
    onTap: () {
      Provider.of<AbilityPathProvider>(context, listen: false).setIndex(index);
    },
    child: Image.asset(
      'assets/hero_icons_small/$heroIconName.jpg',
      width: MediaQuery.of(context).size.width / 12,
    ),
  );
}

const double sideLength = 34;

getAbilitySequence(
    BuildContext context, List abilityList, int heroname, bool isTeamRadiant) {
  return Container(
    alignment: Alignment.topCenter,
    height: (sideLength * 5),
    child: Stack(
      children: [
        GridView(
          padding: const EdgeInsets.fromLTRB(sideLength, 0, 0, 0),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1,
          ),
          children: getAbilityArray(abilityList),
        ),
        getAbilitiesColumn(context, abilityList),
      ],
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
        height: sideLength - 4,
        width: sideLength - 4,
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
      height: sideLength - 2,
      width: sideLength - 2,
      child: const Center(),
    ),
  );
}

nonEmptyBox(var num, int colorIndex) {
  Color temp = Colors.black;
  switch (colorIndex) {
    case 0:
      temp = Color(0xFF67F5F0);
      break;
    case 1:
      temp = Color(0xFF8DF8B4);
      break;

    case 2:
      temp = Color(0xFFB3FA78);
      break;
    case 3:
      temp = Color(0xFFD9FD3C);
      break;
    case 4:
      temp = Color(0xFFFFFF00);
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
      height: sideLength - 2,
      width: sideLength - 2,
      child: Center(
        child: Text(
          '${num + 1}',
          style: TextStyle(color: temp),
        ),
      ),
    ),
  );
}
