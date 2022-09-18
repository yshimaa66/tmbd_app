import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

void showToastMessage(String message){
  showToast(
    message,
    duration: const Duration(seconds: 2),
    position: ToastPosition.bottom,
    backgroundColor: Colors.black.withOpacity(0.8),
    radius: 3.0,
    textStyle: const TextStyle(fontSize: 20.0),
  );
}