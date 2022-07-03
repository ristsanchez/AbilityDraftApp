import 'dart:convert';

import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:ability_draft/abilities/ability_objects/ability.dart';
import 'package:ability_draft/abilities/ability_providers/ability_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

const double indentation = 50;

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
          getTopBarSearch(context),
        ],
      ),
    );
  }
}

getTopBarSearch(BuildContext context) {
  return Container(
    height: indentation,
    child: clearContainerRect(
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  Provider.of<AbilityListProvider>(context, listen: false)
                      .resetSearch();
                },
                child: const Icon(
                  FontAwesomeIcons.arrowsRotate,
                  color: Colors.white38,
                ),
              ),
            ),
            const VerticalDivider(
              thickness: 2,
            ),
            Expanded(
              child: Center(
                child: TextField(
                  enableSuggestions: true,
                  onChanged: (value) {
                    Provider.of<AbilityListProvider>(context, listen: false)
                        .setText(value);
                  },
                  obscureText: false,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 15),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.white60,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    labelText: 'Search',
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              thickness: 2,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                FontAwesomeIcons.chevronDown,
                color: Colors.white38,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

customGrid(BuildContext context) {
  Provider.of<AbilityListProvider>(context, listen: false).initializeList();
  List<Ability> abilityList =
      Provider.of<AbilityListProvider>(context, listen: true).list;

  return abilityList.isEmpty
      ? smallProg()
      : GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(5, indentation + 5, 5, 5),
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
  return Center(
    child: FutureBuilder(
      future: waitOneSec(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            child: CircularProgressIndicator(color: Colors.red),
            height: 50,
            width: 50,
          );
        }
        return snapshot.data;
      },
    ),
  );
}

Future<Text> waitOneSec() async {
  return Future.delayed(const Duration(milliseconds: 1000), () {
    return const Text(
      'No Results',
      style: TextStyle(fontSize: 24),
    );
  });
}
