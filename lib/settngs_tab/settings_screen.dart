import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:ability_draft/utility_futures/json_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsHome extends StatelessWidget {
  const SettingsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Scrollbar(
              thickness: 1,
              child: ListView(
                children: [
                  const Divider(
                    height: 50,
                  ),
                  getThemeTile(),
                  getLanguage(),
                  getExportables(),
                  getSocials(),
                  //keep bottom at the bottom
                  getBottomThanks(),
                ],
              ),
            ),
            getTopBar(),
          ],
        ),
      ),
    );
  }
}
