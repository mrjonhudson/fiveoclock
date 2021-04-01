import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MyThemeModel extends ChangeNotifier {
  bool _isLightTheme =
      SchedulerBinding.instance.window.platformBrightness == Brightness.light;

  void changeTheme() {
    _isLightTheme = !_isLightTheme;
    notifyListeners();
  }

  bool get isLightTheme => _isLightTheme;
}
