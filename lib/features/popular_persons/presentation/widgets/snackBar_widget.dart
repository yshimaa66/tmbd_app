import 'package:flutter/material.dart';

class SnackBarWidget extends StatelessWidget {
  final String textStr, btnText;
  final bool isLoading;
  final void Function() onPressed;

  const SnackBarWidget(
      {Key? key,
      required this.textStr,
      required this.btnText,
      required this.isLoading,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              textStr,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            !isLoading?OutlinedButton(
              onPressed: onPressed,
              child: Text(btnText),
            ):CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
