import 'package:flutter/material.dart';

class Rect4 extends StatefulWidget {
  const Rect4({super.key});

  @override
  State<Rect4> createState() => _Rect4State();
}

class _Rect4State extends State<Rect4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.666,
          color: Colors.blueAccent[400],
          child: const Center(child: Text('Entry 1')),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.66,
          color: Colors.amber[500],
          child: const Center(child: Text('Entry 2')),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.66,
          color: Colors.amber[100],
          child: const Center(child: Text('Entry 3')),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.66,
          color: Color.fromARGB(255, 132, 7, 249),
          child: const Center(
            child: Text('Entry 4'),
          ),
        ),
      ],
    ));
  }
}
