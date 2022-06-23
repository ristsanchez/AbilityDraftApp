import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ability_draft/Stats/Stats.dart';
import 'package:ability_draft/abilities/ability_providers/ability_list_provider.dart';

import 'abilities/index.dart';
import 'heroes/index.dart';
import 'matches/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr =
      await rootBundle.loadString('assets/themes/ad_dark_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(
    //later; Move these to the specific place they will be used at
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AbilityListProvider()),
      ],
      child: MyApp(theme: theme),
    ),
  );
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  const MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  final List<Widget> _tabList = [
    const MatchesHome(),
    const Stats(),
    const AbilitiesHome(),
    const HeroesHome(),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: _tabList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: _tabList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
          });
          _tabController.animateTo(_currentIndex);
        },
        items: const [
          BottomNavigationBarItem(label: ("Matches"), icon: Icon(Icons.list)),
          BottomNavigationBarItem(
              label: ("Stats"), icon: Icon(Icons.query_stats)),
          BottomNavigationBarItem(label: ("Abilities"), icon: Icon(Icons.apps)),
          BottomNavigationBarItem(
              label: ("Heroes"), icon: FaIcon(FontAwesomeIcons.userAstronaut)),
        ],
      ),
    );
  }
}
