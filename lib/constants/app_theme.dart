import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'font_family.dart';
import 'colors.dart';

final ThemeData themeData = new ThemeData(
    fontFamily: FontFamily.productSans,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: MaterialColor(AppColors.orange[500].value, AppColors.orange),
    primaryColor: AppColors.orange[500],
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.orange[500],
    accentColorBrightness: Brightness.light);

final ThemeData themeDataDark = ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: AppColors.orange[500],
  primaryColorBrightness: Brightness.dark,
  accentColor: AppColors.orange[500],
  accentColorBrightness: Brightness.dark,
);

final ThemeData myTheme = ThemeData(
  fontFamily: FontFamily.balsamiqSans,
  textTheme: TextTheme(
    headline3: TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
    headline4: TextStyle(
      fontSize: 20,
      color: Colors.yellow,
    ),
  ),
  buttonTheme: ButtonThemeData(buttonColor: Colors.white),
);

final ThemeData mrRobotTheme = ThemeData(
  fontFamily: FontFamily.mrrobot,
  textTheme: TextTheme(
    headline6: TextStyle(
      fontSize: 60,
      color: Colors.red,
    ),
  ),
);

final ThemeData terminalTheme = ThemeData(
  fontFamily: FontFamily.vT323Regular,
  textTheme: TextTheme(
    headline6: TextStyle(
      fontSize: 60,
      color: Colors.red,
    ),
    headline1: TextStyle(
      fontSize: 30,
      color: Colors.green[700],
    ),
    headline2: TextStyle(
      fontSize: 30,
      color: Colors.white,
    ),
    headline3: TextStyle(
      fontSize: 30,
      color: Colors.red,
    ),
  ),
);

final myStyleSheet = MarkdownStyleSheet(
  h1: TextStyle(
    fontFamily: FontFamily.productSans,
    fontSize: 70,
    color: Colors.white,
  ),
);
