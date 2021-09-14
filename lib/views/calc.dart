import 'package:dwri_baloot/widgets/alrt.dart';
import 'package:dwri_baloot/widgets/main_box_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Calculator extends StatefulWidget {
  int res1 = 0;
  int res2 = 0;

  Calculator({
    this.res1 = 0,
    this.res2 = 0,
  });

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator>
    with SingleTickerProviderStateMixin {
  GlobalKey<AnimatedListState> _list = GlobalKey<AnimatedListState>();
  GlobalKey<AnimatedListState> _list2 = GlobalKey<AnimatedListState>();

  late AnimationController _acontroller;
  late Animation<Size> _heightcontroller;

  @override
  void initState() {
    super.initState();

    _acontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _heightcontroller = Tween<Size>(
            begin: const Size(double.infinity, 0),
            end: const Size(double.infinity, 30))
        .animate(CurvedAnimation(parent: _acontroller, curve: Curves.easeIn));
    _heightcontroller.addListener(() {
      setState(() {});
    });
  }

  final List<int> _val1 = [];
  final List<int> _val2 = [];

  final _txt1 = TextEditingController();
  final _txt2 = TextEditingController();

  bool isEnabled = true;
  bool isEnugh = false;

  @override
  void dispose() {
    _txt1.dispose();
    _txt2.dispose();
    _acontroller.dispose();

    super.dispose();
  }

  void newGame(value) async {
    try {
      if (value == -1) {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogBox(
                  title: "🤔🤔",
                  descriptions: "انت متأكد",
                  text: "نعم",
                  text1: "لا");
            }).then((value) {
          if (value == 0) {
            widget.res1 = value;
            widget.res2 = value;
            _val1.clear();
            _val2.clear();
            setState(() {});
          } else {
            return;
          }
        });
      } else if (value == 1) {
        return;
      } else {
        isEnabled = true;
        widget.res1 = value;
        widget.res2 = value;
        _val1.clear();
        _val2.clear();
      }
      setState(() {});
    } catch (e) {
      rethrow;
    }
  }

  void _add(val1, val2) async {
    // try {
    setState(() {
      if (val1 == "0" && val2 == "0") return;

      if (_txt1.text.contains("-") ||
          _txt1.text.contains(",") ||
          _txt1.text.contains(".") ||
          _txt1.text.contains(RegExp("[a-z]"))) return;

      if (_txt2.text.contains("-") ||
          _txt2.text.contains(",") ||
          _txt2.text.contains(".") ||
          _txt2.text.contains(RegExp("[a-z]"))) return;

      _val1.add(int.parse(val1));
      _val2.add(int.parse(val2));
      _list.currentState?.insertItem(_val1.length - 1);
      _list2.currentState?.insertItem(_val2.length - 1);

      widget.res1 = _val1.fold(0, (p, e) => p + e);
      widget.res2 = _val2.fold(0, (p, e) => p + e);

      if (widget.res1 >= 152) {
        isEnabled = false;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogBox(
                title: "😂🤣",
                descriptions: " قامت عليهم ",
                text: "تسجيلة جديدة",
                text1: "مراجعة",
              );
            }).then((value) => newGame(value));
      } else if (widget.res2 >= 152) {
        isEnabled = false;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogBox(
                title: "🤣😂",
                descriptions: "قامت عليكم",
                text: "تسجيلة جديدة",
                text1: "مراجعة",
              );
            }).then((value) => newGame(value));
      }

      _txt1.text = "";
      _txt2.text = "";
    });
    // } catch (e) {
    //   rethrow;
    // }
  }

  Widget countList() {
    return AnimatedList(
      key: _list,
      initialItemCount: _val1.length,
      itemBuilder: (context, index, anima) {
        return FadeTransition(
          opacity: anima.drive(opa),
          child: Column(
            children: [
              ShadowedBox(
                  hight: 45,
                  width: 100,
                  child: Center(child: Text(_val1[index].toString()))),
              Container(
                height: 30,
              )
            ],
          ),
        );
      },
    );
  }

  Widget countList2() {
    return AnimatedList(
      key: _list2,
      initialItemCount: _val2.length,
      itemBuilder: (context, index, anima) {
        return FadeTransition(
          opacity: anima.drive(opa),
          child: Column(
            children: [
              ShadowedBox(
                  hight: 45,
                  width: 100,
                  child: Center(child: Text(_val2[index].toString()))),
              Container(
                height: 30,
              )
            ],
          ),
        );
      },
    );
  }

  Tween<double> opa = Tween(begin: 0, end: 1);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      color: Colors.grey[600],
                      onPressed: () {
                        if (_val1.isNotEmpty) {
                          if (_val1.length == 1) {
                            newGame(0);
                            return;
                          }
                          widget.res1 = widget.res1 - _val1.last;
                          widget.res2 = widget.res2 - _val2.last;
                          _val1.removeLast();
                          _val2.removeLast();

                          _list.currentState!.removeItem(_val1.length - 1,
                              (context, animation) => Container());

                          _list2.currentState!.removeItem(_val2.length - 1,
                              (context, animation) => Container());

                          if (widget.res1 <= 152 || widget.res1 <= 152) {
                            isEnabled = true;
                          }
                        }
                        setState(() {});
                      },
                      icon: const Icon(Icons.undo)),
                  IconButton(
                      color: Colors.grey[600],
                      onPressed: () {
                        _add((_txt1.text == "") ? "0" : _txt1.text,
                            (_txt2.text == "") ? "0" : _txt2.text);
                      },
                      icon: const Icon(Icons.check_sharp)),
                  IconButton(
                      color: Colors.grey[600],
                      onPressed: () {
                        if (isEnabled == false) {
                          newGame(0);
                          isEnabled = true;
                        } else {
                          newGame(-1);
                        }
                      },
                      icon: const Icon(Icons.refresh))
                ],
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "لنا",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            ShadowedBox(
                              hight: 50,
                              width: 118,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                ),
                                enabled: isEnabled,
                                onSubmitted: (val) => _add(
                                    (_txt1.text == "") ? "0" : _txt1.text,
                                    (_txt2.text == "") ? "0" : _txt2.text),
                                controller: _txt1,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: (_val1.isNotEmpty)
                                    ? countList()
                                    : const Text("")),
                            ShadowedBox(
                              hight: 60,
                              width: 150,
                              child:
                                  Center(child: Text(widget.res1.toString())),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "لهم",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            ShadowedBox(
                              hight: 50,
                              width: 118,
                              child: TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true, signed: false),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                ),
                                enabled: isEnabled,
                                onSubmitted: (val) => _add(
                                    (_txt1.text == "") ? "0" : _txt1.text,
                                    (_txt2.text == "") ? "0" : _txt2.text),
                                controller: _txt2,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: (_val1.isNotEmpty)
                                    ? countList2()
                                    : const Text("")),
                            ShadowedBox(
                              hight: 60,
                              width: 150,
                              child:
                                  Center(child: Text(widget.res2.toString())),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
