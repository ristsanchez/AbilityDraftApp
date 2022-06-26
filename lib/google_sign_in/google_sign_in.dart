import 'dart:convert';

import 'package:ability_draft/google_sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class GoogleSignInRename extends StatelessWidget {
  const GoogleSignInRename({Key? key, required this.theme}) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    // we return the MaterialApp here ,
    // MaterialApp contain some basic ui for android ,
    return MaterialApp(
      //materialApp title
      title: 'Go tigersssss!',
      debugShowCheckedModeBanner: false,
      theme: theme,
      // home property contain SignInScreen widget
      home: FutureProvider<List?>(
        initialData: const [],
        create: (_) => _getHeroNames(),
        child: const SignInScreen(),
      ),
    );
  }
}

Future<List> _getHeroNames() async {
  String data = await rootBundle.loadString('lib/gameData/HeroesCond.json');
  Map<String, dynamic> map = json.decode(data);
  return map.keys.toList();
}
