import 'package:course_flutter/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey[900],
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.grey[900],
    elevation: 0.0,
    titleTextStyle: TextStyle(
        fontSize: 23.0,
        fontWeight: FontWeight.bold,
        color: Colors.white
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme:
  BottomNavigationBarThemeData(
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.white,
      backgroundColor:  Colors.grey[900]
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 17.0
    ),
  ),
);
ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 17.0
    ),
  ),
  bottomNavigationBarTheme:
  BottomNavigationBarThemeData(selectedItemColor: defaultColor , unselectedItemColor: Colors.grey),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
        fontSize: 23.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87),
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
  ),
);
