import 'package:flutter/material.dart';

class ShadowedBox extends StatelessWidget {
  final Widget? child;
  final double hight;
  final double width;

  // ignore: use_key_in_widget_constructors
  const ShadowedBox({this.child, required this.hight, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: child,
        width: width,
        height: hight,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 18,
                  offset: const Offset(0, 7),
                  color: Colors.grey.withOpacity(0.5))
            ]));
  }
}
