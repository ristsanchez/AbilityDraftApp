import 'dart:convert';

import 'package:ability_draft/firebase/firebase_options.dart';
import 'package:ability_draft/google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ability_draft/abilities/ability_providers/ability_list_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final themeStr =
      await rootBundle.loadString('assets/themes/ad_dark_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AbilityListProvider()),
      ],
      child: GoogleSignInRename(theme: theme),
    ),
  );
}
