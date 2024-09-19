import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 1st. if current theme is dark change to light vice versa, then notify the listeners about ThemeNotifier(done below)
// 2nd. provide the ThemeNotifier to widget tree(made in main)
// 3rd. consume the provided ThemeNotifier and update the UI based on that(made on MyApp)
// 4th. finally make the Button but set the UI rebuild to 'false' since changing theme don't need to rebuild ui

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode =  ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  void ToggleTheme(){
    if(_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    }else{
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}