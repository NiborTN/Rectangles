import 'package:flutter/material.dart';
import 'dart:math';

class Rect40 extends StatefulWidget {
  const Rect40({super.key});

  @override
  State<Rect40> createState() => _Rect40State();
}

class _Rect40State extends State<Rect40> {
  final _tiles = List<String>.generate(40, (index) => 'item ${index + 1}');
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
    return Scaffold(
      body: ListView.builder(
        itemCount: 41,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.66,
            child: ListTile(
              title: Text(_tiles[index]),
              tileColor: colors[random.nextInt(4)],
            ),
          );
        },
      ),
    );
  }
}
