import 'package:ability_draft/google_sign_in/sign_in_widget.dart';
import 'package:flutter/material.dart';

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
      home: const SignInScreen(),
    );
  }
}
