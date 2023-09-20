import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 11, 0, 61);
  static const Color secondary = Color.fromARGB(255, 0, 12, 66);
  
  static final ThemeData customTheme = ThemeData(
    primaryColor: Colors.greenAccent,
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 10,
    ),
    textTheme: TextTheme(
     
      bodyText2: TextStyle(
        color: Colors.black,
        // fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Color.fromARGB(255, 5, 0, 34)),
      floatingLabelStyle: TextStyle(color: primary),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary), 
      ),
    ),
  );
}
