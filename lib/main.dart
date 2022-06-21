import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ability_draft/Stats/Stats.dart';
import 'package:ability_draft/abilities/ability_providers/ability_list_provider.dart';

import 'abilities/index.dart';
import 'heroes/index.dart';
import 'matches/index.dart';

void main() {
  runApp(
    //Move these to the specific place they will be used at
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AbilityListProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
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
    const AbilitiesHome(),
    const HeroesHome(),
    const Stats(),
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
        backgroundColor: Colors.grey,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        onTap: (currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
          });
          _tabController.animateTo(_currentIndex);
        },
        items: const [
          BottomNavigationBarItem(label: ("Matches"), icon: Icon(Icons.apps)),
          BottomNavigationBarItem(label: ("Abilities"), icon: Icon(Icons.face)),
          BottomNavigationBarItem(label: ("Heroes"), icon: Icon(Icons.cabin)),
          BottomNavigationBarItem(label: ("Stats"), icon: Icon(Icons.dangerous))
        ],
      ),
    );
  }
}
