import 'package:flutter/material.dart';

ThemeData getMyTheme() => ThemeData(
  fontFamily: "Georgia",
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: Colors.amber,
  ),
  textTheme: TextTheme(
    headline5: TextStyle(
          fontSize: 30.0,
          height: 1.21,
          color: Color.fromRGBO(0, 0, 0, 1)
      ),
    headline6: TextStyle(
        fontSize: 16.0,
        height: 1.21,
        color: Color.fromRGBO(0, 0, 0, 1)
    ),
    bodyText1: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      height: 1.17,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 18.0,
      height: 1.21,
      color: Color.fromRGBO(0, 0, 0, 1),
    ),
  )
);
