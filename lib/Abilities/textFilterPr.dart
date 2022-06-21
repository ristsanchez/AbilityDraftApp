import 'package:ability_draft/Abilities/Abilities.dart';
import 'package:ability_draft/Abilities/Ability.dart';
import 'package:flutter/foundation.dart';

class AbiFilterProvider extends ChangeNotifier {
  final ValueNotifier<String> _textNotifier = ValueNotifier<String>('');
  ValueNotifier<String> get text => _textNotifier;

  void setText(String text) => _textNotifier.value = text;
}
