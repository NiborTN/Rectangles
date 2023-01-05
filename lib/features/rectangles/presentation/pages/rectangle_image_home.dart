import 'package:flutter/material.dart';
import 'Rectangle.dart';

class RectangleImageHome extends StatelessWidget {
  const RectangleImageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rectangle Home'),
      ),
      body: const MenuOptions(),
    );
  }
}

class MenuOptions extends StatelessWidget {
  const MenuOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Rect42(count: 4)),
              );
            },
            child: const Text('4 Rectangles'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Rect42(count: 40)),
              );
            },
            child: const Text('40 Rectangles'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Rect42(count: 400)),
              );
            },
            child: const Text('400 Rectangles'),
          ),
        ],
      ),
    );
  }
}
