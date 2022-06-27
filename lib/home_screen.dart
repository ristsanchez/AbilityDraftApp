import 'dart:convert';

import 'package:ability_draft/abilities/index.dart';
import 'package:ability_draft/heroes/index.dart';
import 'package:ability_draft/matches/ability_path_provider.dart';
import 'package:ability_draft/matches/index.dart';
import 'package:ability_draft/matches/index_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'Stats/Stats.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  final List<Widget> _tabList = [
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IndexChangeProvider()),
        ChangeNotifierProvider(create: (_) => AbilityPathProvider()),
      ],
      child: const MatchesHome(),
    ),
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
