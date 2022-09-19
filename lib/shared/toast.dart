import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tmdb_app/main.dart';

void showToastMessage(String message,
    Color backgroundColor){
  ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Text(message,
        style: const TextStyle(color: Colors.white),),
    ),
  );
}