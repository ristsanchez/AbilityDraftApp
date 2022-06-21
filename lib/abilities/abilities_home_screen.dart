import 'dart:convert';

import 'package:ability_draft/abilities/ability_objects/ability.dart';
import 'package:ability_draft/abilities/ability_providers/ability_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbilitiesHome extends StatelessWidget {
  const AbilitiesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //maybe later//List abis = Provider.of<List<Ability>>(context);
    return Center(
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getSearchPartRENAME(context),
            customGrid(context),
          ],
        ),
      ),
    );
  }
}

getSearchPartRENAME(BuildContext context) {
  Provider.of<AbilityListProvider>(context, listen: false).list;
  return Container(
    height: 230,
    color: Colors.blue,
    child: Column(
      children: [
        SizedBox(
          height: 59,
        ),
        Container(
          color: Colors.white,
          child: TextField(
            enableSuggestions: true,
            // autofillHints:
            //     Provider.of<AbilityListProvider>(context, listen: false)
            //         .abilityHintList,
            onChanged: (value) {
              Provider.of<AbilityListProvider>(context, listen: false)
                  .setText(value);
            },
            cursorColor: Colors.red,
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search',
            ),
          ),
        ),
        Container(
          child: Text(
            Provider.of<AbilityListProvider>(context).list.length.toString(),
          ),
        ),
      ],
    ),
  );
}

customGrid(BuildContext context) {
  Provider.of<AbilityListProvider>(context, listen: false).initializeList();
  List<Ability> abilityList =
      Provider.of<AbilityListProvider>(context, listen: false).list;

  return abilityList.isEmpty
      ? smallProg()
      : Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1,
              crossAxisCount: 4,
            ),
            itemCount: Provider.of<AbilityListProvider>(context).list.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // showAbilityDialog(context, abilityList[index]);
                },
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        'assets/ability_images/${Provider.of<AbilityListProvider>(context).list[index].name}.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          Provider.of<AbilityListProvider>(context)
                              .list[index]
                              .id,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
}

smallProg() {
  return Expanded(
    child: Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(color: Colors.red),
      height: 50,
      width: 50,
    ),
  );
}

// @override
// Widget build(BuildContext context) {
//   return ScopedModelDescendant<AbilitiesModel>(
//     builder: (BuildContext context, Widget child, AbilitiesModel model) {
//       return Scaffold(
//         body: Center(
//           child: FutureBuilder(
//             future: _allAbiData(context),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//                 print("rebuilding from futurebuilder");
//                 actualList = snapshot.data;
//                 return _buildEmpty(context);
//                 // return _buildAbiContents(context, snapshot.data);
//               } else if (snapshot.hasError) {
//                 return Container(
//                   color: Colors.red,
//                   child: const Text('error:('),
//                 );
//               } else {
//                 return const CircularProgressIndicator();
//               }
//             },
//           ),

//           // _buildContents(context, model),
//         ),
//       );
//     },
//   );
// }

Future<List<Ability>> _allAbiData(BuildContext context) async {
  String data2 = await DefaultAssetBundle.of(context)
      .loadString('lib/gameData/Abilitiesprog.json');
  String data = await DefaultAssetBundle.of(context)
      .loadString('lib/gameData/HeroesCond.json');
  String data3 = await DefaultAssetBundle.of(context)
      .loadString('lib/gameData/abilities_english.json');

  Map<String, dynamic> map = json.decode(data);
  Map<String, dynamic> map2 = json.decode(data2);
  Map<String, dynamic> map3 = json.decode(data3);

  List<Ability> res = [];
  List<int> djang = [1, 2, 3, 6];
  Map<String, String> temp = {};

  map.forEach((k, v) {
    // if (k == 'antimage' || k == 'axe') {
    for (int i in djang) {
      map3[k].forEach((descKey, descValue) {
        if (descKey
            .toString()
            .contains('DOTA_Tooltip_ability_${v['Ability$i']}')) {
          temp[descKey] = descValue;
        }
      });

      res.add(
        Ability.fromJson(v['Ability$i'], map2[v['Ability$i']], temp),
      );
      temp = {};
    }
  });
  return res;
  // return Future.delayed(const Duration(seconds: 2)).then((onValue) => res);
}
// }

// _buildAbiContents(BuildContext context, List<Ability> abilityList) {
//   return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints viewportConstraints) {
//     return SingleChildScrollView(
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           minHeight: viewportConstraints.maxHeight,
//         ),
//         child: IntrinsicHeight(
//           child: Column(children: <Widget>[
//             Container(
//               // A fixed-height child.
//               color: const Color.fromARGB(255, 60, 97, 199), // Yellow
//               height: 60.0,
//               alignment: Alignment.center,

//               //get all from db, count it, display it as string
//               child: Center(),
//             ),
//             Expanded(
//               // A flexible child that will grow to fit the viewport but
//               // still be at least as big as necessary to fit its contents.
//               child: Container(
//                 color: Colors.blueGrey, // Red
//                 height: 120.0,
//                 alignment: Alignment.center,
//                 child: GridView.builder(
//                     shrinkWrap: true,
//                     padding: const EdgeInsets.all(5),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       mainAxisSpacing: 3,
//                       crossAxisSpacing: 3,
//                       childAspectRatio: 1,
//                       crossAxisCount: 4,
//                     ),
//                     itemCount: abilityList.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                           showAbilityDialog(context, abilityList[index]);
//                         },
//                         child: Stack(children: <Widget>[
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10.0),
//                             child: Image.asset(
//                               'assets/ability_images/${abilityList[index].name}.png',
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.all(5),
//                             child: Align(
//                               alignment: Alignment.bottomLeft,
//                               child: RichText(
//                                 textAlign: TextAlign.left,
//                                 text: TextSpan(
//                                   text: abilityList[index].id,
//                                   style: const TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           //$LAZY$ VERISON, FIND A WAY TO WRITE THE PROPER HERO NAME
//                         ]),
//                       );
//                     }),
//               ),
//             )
//           ]),
//         ),
//       ),
//     );
//   });

