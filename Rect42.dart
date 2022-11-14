import 'dart:math';

import 'package:flutter/material.dart';

class Rect42 extends StatefulWidget {
  final int count;

  const Rect42({Key? key, required this.count}) : super(key: key);

  @override
  State<Rect42> createState() => _Rect42State();
}

class ListColour<listRow> {
  // class created to generate a radom colour for each row within the the ListView
  late Color tileColour =
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  void changeColour1(tileColour) {
    //method creatd to change the colour of the row
    this.tileColour = tileColour;
    tileColour = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}

class _Rect42State extends State<Rect42> {
  late List tiles;

  @override
  void initState() {
    super.initState();
    tiles = List.generate(widget.count, (index) => ListColour().tileColour);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => buildRow(index),
        itemCount: tiles.length,
      ),
    );
  }

  Widget buildRow(int index) {
    final track = tiles[index];
    final containerRow = Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text('change colour'),
            const Spacer(),
            const Text('change colour'),
          ],
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: track,
      ),
      onDismissed: (direction) {
        setState(
          () {
            int currentIndex = tiles.indexOf(track);
            tiles.remove(track);
            tiles.insert(currentIndex, ListColour().tileColour);
          },
        );
      },
    );
    Draggable draggable = LongPressDraggable(
      data: track,
      axis: Axis.vertical,
      feedback: Material(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: containerRow,
        ),
      ),
      child: containerRow,
    );
    return DragTarget<Color>(
      onWillAccept: (track) {
        return tiles.indexOf(track!) != index;
      },
      onAccept: (track) {
        setState(
          () {
            int currentIndex = tiles.indexOf(track);
            tiles.remove(track);
            tiles.insert(currentIndex > index ? index : index - 1, track);
          },
        );
      },
      builder: (BuildContext context, List candidateData,
          List<dynamic> rejectedData) {
        return Column(
          children: <Widget>[
            AnimatedSize(
              duration: const Duration(milliseconds: 100),
              child: candidateData.isEmpty
                  ? Container()
                  : Opacity(
                      opacity: 0.0,
                      child: containerRow,
                    ),
            ),
            Card(
              child: candidateData.isEmpty ? draggable : containerRow,
            )
          ],
        );
      },
    );
  }
}
