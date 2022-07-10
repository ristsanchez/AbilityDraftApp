import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  Theme theme;

  SettingsProvider(
    this.theme,
  );

  setTheme(bool isDark) {}
}
