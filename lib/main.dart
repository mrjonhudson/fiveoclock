import 'package:fiveoclock/models/my_theme_provider.dart';
import 'package:fiveoclock/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'screens/home_screen.dart';

void main() {
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyThemeModel(),
        child: Consumer<MyThemeModel>(
          builder: (context, theme, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Five O\'Clock',
            theme: themeData(context),
            darkTheme: darkThemeData(context),
            themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
            home: HomeScreen(),
          ),
        ));
  }
}
