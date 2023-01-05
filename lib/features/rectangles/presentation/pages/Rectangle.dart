// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: file_names

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:the_boxesv3/features/rectangles/domain/entities/rectiangle_image.dart';
import 'package:the_boxesv3/features/rectangles/presentation/bloc/rectangle_imports.dart';
import 'package:the_boxesv3/injection_container.dart';

class Rect42 extends StatelessWidget {
  final int count;

  const Rect42({Key? key, required this.count}) : super(key: key);

  int getCount() {
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rectangle Image List'),
      ),
      body: buildBody(),
    );
  }

  BlocProvider<RectangleBloc> buildBody() {
    sl.allowReassignment = true;
    sl.registerLazySingleton(() => getCount());
    return BlocProvider(
      create: (_) => sl.get<RectangleBloc>()..add(const LoadRectangle()),
      child: BlocBuilder<RectangleBloc, RectangleState>(
        builder: (context, state) {
          if (state is RectangleLoading) {
            return const CircularProgressIndicator();
          } else if (state is RectangleLoaded) {
            return ImageListView(imageList: state.imageList);
          } else if (state is Error) {
            return Center(
              child: Text(state.message, textDirection: TextDirection.ltr),
            );
          } else {
            return const Center(
                child: Text('something went wrong',
                    textDirection: TextDirection.ltr));
          }
        },
      ),
    );
  }
}

class ImageListView extends StatelessWidget {
  const ImageListView({
    Key? key,
    required this.imageList,
  }) : super(key: key);

  final List<RectangleImage> imageList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageList.length,
      itemBuilder: (BuildContext context, int index) {
        final image = imageList[index];
        final containerRow = DismissImage(image: image, index: index);
        DragImage draggable =
            DragImage(image: image, containerRow: containerRow);
        return DragImageTarget(
            containerRow: containerRow,
            draggable: draggable,
            index: index,
            imageList: imageList);
      },
    );
  }
}

class DragImageTarget extends StatelessWidget {
  const DragImageTarget({
    Key? key,
    required this.containerRow,
    required this.draggable,
    required this.imageList,
    required this.index,
  }) : super(key: key);

  final DismissImage containerRow;
  final DragImage draggable;
  final List<RectangleImage> imageList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return DragTarget<RectangleImage>(
      onWillAccept: (image) {
        return imageList.indexOf(image!) != index;
      },
      onAccept: (image) {
        context.read<RectangleBloc>().add(MoveRectangle(image, index));
      },
      builder: (context, List candidateData, List<dynamic> rejectedData) {
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

class DragImage extends StatelessWidget {
  const DragImage({
    Key? key,
    required this.image,
    required this.containerRow,
  }) : super(key: key);

  final RectangleImage image;
  final DismissImage containerRow;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: image,
      axis: Axis.vertical,
      feedback: Material(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: double.infinity),
          child: containerRow,
        ),
      ),
      child: containerRow,
    );
  }
}

class DismissImage extends StatelessWidget {
  const DismissImage({
    Key? key,
    required this.image,
    required this.index,
  }) : super(key: key);

  final RectangleImage image;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(index),
      background: ColoredBox(
        color: Colors.red,
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text('change image'),
            const Spacer(),
            const Text('change image'),
          ],
        ),
      ),
      child: remoteOrLocal(),
      onDismissed: (direction) {
        context.read<RectangleBloc>().add(ChangeRectangle(image, index));
      },
    );
  }

  remoteOrLocal() {
    try {
      return Image.network(image.url,
          height: 100, width: 400, fit: BoxFit.cover);
    } on SocketException {
      return Container(
        height: 100,
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      );
    }
  }
}
