import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.deepPurple,
  colorScheme: const ColorScheme.light(
      primary: Colors.deepPurple,
      background : Color.fromARGB(255, 255, 255, 255),
      onBackground: Color.fromARGB(255, 0, 0, 0),
      secondary: Color.fromARGB(255, 141, 144, 151)),
  canvasColor: const Color.fromARGB(255, 255, 255, 255),
  textTheme: const TextTheme(
    bodyLarge:  TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  hintColor: const Color.fromARGB(255, 141, 144, 151),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple,), //button color
    ),
  ),
);