import 'package:flutter/material.dart';
import 'package:the_boxes/views/Rect4.dart';
import 'package:the_boxes/views/Rect400.dart';
import 'package:the_boxes/views/Rect42.dart';
import 'package:the_boxes/views/rect40.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Rectangles',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rectangle Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Rect42(count: 4)),
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
      ),
    );
  }
}
