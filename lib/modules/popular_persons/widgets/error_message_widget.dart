import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String textStr,btnText;
  final void Function() onPressed;
  const ErrorMessageWidget({Key? key, required this.textStr,
    required this.btnText, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          textStr,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: onPressed,
          child: Text(btnText),
        ),],),);
  }
}
