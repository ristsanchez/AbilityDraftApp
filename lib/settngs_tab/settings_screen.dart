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

Widget getTopBar() {
  return clearContainerRect(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 50.0,
      alignment: Alignment.center,
      child: const Text(
        'More',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}

getThemeTile() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
    child: Column(
      children: const [
        ListTile(
          leading: Padding(
            padding: EdgeInsets.only(top: 7),
            child: Icon(Icons.invert_colors),
          ),
          title: Text('Theme'),
          subtitle: Text('Dark'),
        ),
      ],
    ),
  );
}

getLanguage() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: ListTile(
      leading: Padding(
        padding: EdgeInsets.only(top: 4),
        child: Icon(
          Icons.language,
          size: 24,
        ),
      ),
      title: Text('Language'),
      subtitle: Text('English'),
      trailing: Text(
        'More coming soon',
        style: TextStyle(color: Colors.white30),
      ),
    ),
  );
}

getExportables() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Column(
      children: const [
        ListTile(
          leading: Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.cloud),
          ),
          title: Text('Cloud backup'),
          subtitle: Text('Google Drive'),
        ),
        Divider(
          thickness: 3,
          height: 3,
        ),
        ListTile(
          leading: Icon(Icons.sim_card_download_rounded),
          title: Text('Export Entries'),
        ),
      ],
    ),
  );
}
