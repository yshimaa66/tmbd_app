import 'package:flutter/material.dart';

ThemeData darkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.amber,
      primaryColor: Colors.amberAccent,
      scaffoldBackgroundColor: const Color(0xFF121212),
      backgroundColor: Colors.black,
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.black),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF121212),
        iconTheme: const IconThemeData(color: Colors.white70),
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white70,
              fontFamily: 'Ubuntu',
            ),
        elevation: 0,
      ),
    );
