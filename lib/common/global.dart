import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 主题颜色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static SharedPreferences _pref;
}