import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shenku/logic/events/intents/shen_scaffold.dart';

final shenScaffoldNavigation = <LogicalKeySet, Intent>{
  LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyD):
      const FowardIntent(),
  LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA):
      const BackIntent(),
};
