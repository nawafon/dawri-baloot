import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './views/calc.dart';

void main() {
  runApp(Balot());
}

// ignore: use_key_in_widget_constructors
class Balot extends StatefulWidget {
  @override
  State<Balot> createState() => _BalotState();
}

class _BalotState extends State<Balot> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            textTheme: const TextTheme(
                bodyText1: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Dim',
                    color: Color.fromRGBO(150, 150, 150, 1)),
                bodyText2: TextStyle(
                    fontSize: 27,
                    fontFamily: 'hacen',
                    color: Color.fromRGBO(150, 150, 150, 1)),
                button: TextStyle(
                    fontSize: 20, fontFamily: 'hacen', color: Colors.grey))),
        home: Calculator());
  }
}
