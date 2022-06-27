import 'dart:convert';

import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:ability_draft/abilities/ability_objects/ability.dart';
import 'package:ability_draft/abilities/ability_providers/ability_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const double indentation = 60;

class AbilitiesHome extends StatelessWidget {
  const AbilitiesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //maybe later//List abis = Provider.of<List<Ability>>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Stack(
        children: <Widget>[
          customGrid(context),
          getSearchPartRENAME(context),
        ],
      ),
    );
  }
}

getSearchPartRENAME(BuildContext context) {
  Provider.of<AbilityListProvider>(context, listen: false).list;
  return SizedBox(
    height: indentation,
    // width: MediaQuery.of(context).size.width,
    child: clearContainerRect(
      Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
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
                      // labelText: 'Search',
                    ),
                  ),
                ),
                SizedBox(
                  width: 1,
                )
              ],
            ),
          ),
          Container(
            child: Text(
              Provider.of<AbilityListProvider>(context).list.length.toString(),
            ),
          ),
        ],
      ),
    ),
  );
}

customGrid(BuildContext context) {
  Provider.of<AbilityListProvider>(context, listen: false).initializeList();
  List<Ability> abilityList =
      Provider.of<AbilityListProvider>(context, listen: false).list;

  return abilityList.isEmpty
      ? smallProg()
      : GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(5, indentation, 5, 5),
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
        );
}

smallProg() {
  return Container(
    alignment: Alignment.center,
    child: const CircularProgressIndicator(color: Colors.red),
    height: 50,
    width: 50,
  );
}
