import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_design/WeatherApp/Home.dart';
import 'package:flutter_ui_design/WeatherApp/theme.dart';
import 'package:flutter_ui_design/WeatherApp/themeNotifier.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
        child: myApp(),
    )
  );
}


class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeNotifier.themeMode,
          debugShowCheckedModeBanner: false,
          home: homepage(),
        );
      },
    );
  }
}
