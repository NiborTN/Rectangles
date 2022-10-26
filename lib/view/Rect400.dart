import 'package:flutter/material.dart';
import 'dart:math';

class Rect400 extends StatefulWidget {
  const Rect400({super.key});

  @override
  State<Rect400> createState() => _Rect400State();
}

class _Rect400State extends State<Rect400> {
  //final _tiles = List<String>.generate(400, (index) => 'item ${index + 1}');
  List colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.white,
    Colors.blue
  ];
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    List<Widget> mywidgets = [];
    for (int x = 1; x <= 400; x++) {
      mywidgets.add(Container(
        color: colors[random.nextInt(4)],
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.66,
        child: Text('item $x'),
      ));
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: mywidgets,
        ),
      ),
    );
  }
}
