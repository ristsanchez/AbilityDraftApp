import 'dart:ui';
import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:ability_draft/heroes/hero_providers/hero_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'hero_dialogs/hero_stats_dialog.dart';
import 'heroes_objects/hero.dart';

const double indentation = 60;

class HeroesHome extends StatelessWidget {
  const HeroesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Stack(
        children: <Widget>[
          _getHeroesGrid(context),
          getTopBarSearch(context),
        ],
      ),
    );
  }
}

getTopBarSearch(BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
    height: indentation,
    child: clearContainerRect(
      Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                FontAwesomeIcons.arrowsRotate,
                color: Colors.white38,
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
                    Provider.of<HeroListProvider>(context, listen: false)
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

_getHeroesGrid(BuildContext context) {
  Provider.of<HeroListProvider>(context, listen: false).initList();
  List<AHero> heroList =
      Provider.of<HeroListProvider>(context, listen: true).list;

  return heroList.isEmpty
      ? const Center(child: CircularProgressIndicator(color: Colors.purple))
      : GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(5, indentation, 5, 5),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.78,
            crossAxisCount: 3,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
          ),
          itemCount: heroList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                showHeroDialog(context, heroList[index]);
              },
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/hero_portraits_big/${heroList[index].base_name}.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 3),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: heroList[index].name,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
}

getIconsFilterBar(BuildContext context) {
  return Container(
    margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              getElevatedButton('hero_strength'),
              getElevatedButton('hero_agility'),
              getElevatedButton('hero_intelligence'),
              Container(
                height: 35,
                width: 100,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'XP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('co'),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

getElevatedButton(String icon) {
  return ElevatedButton(
    onPressed: () {},
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 3,
          left: 1,
          child: Opacity(
              child: Image.asset(
                'assets/stats_icons_small/$icon.png',
                color: Colors.black,
                width: 30,
              ),
              opacity: 0.6),
        ),
        Positioned(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Image.asset(
                'assets/stats_icons_small/$icon.png',
                width: 30,
              ),
            ),
          ),
        ),
      ],
    ),
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(4),
      primary: const Color.fromARGB(255, 126, 126, 126), // <-- Button color
      onPrimary: Colors.white, // <-- Splash color
    ),
  );
}

primaryAtt(String att) {
  switch (att) {
    case 'str':
      return "Strength";
    case 'agi':
      return "Agility";
    case 'int':
      return "Intelligence";
    default:
      return "";
  }
}
