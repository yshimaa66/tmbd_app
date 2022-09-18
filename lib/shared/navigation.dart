import 'package:flutter/material.dart';

/// Navigation

void navigateTo(context, widget) =>
  Navigator.push(
  context, MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndReplacement(context, widget) =>
  Navigator.pushReplacement(
  context, MaterialPageRoute(
  builder: (context) => widget,),
);

void navigateAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(
      builder: (context) => widget,
    ), (Route<dynamic> route) => false);

