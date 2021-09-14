import 'dart:ui';

import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const WhiteButton({Key? key, this.text = "", required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.button,
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.white, shadowColor: Colors.grey[300]));
  }
}
