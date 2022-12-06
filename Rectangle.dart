import 'package:flutter/material.dart';
import 'package:the_boxesv2/bloc/rectangle_imports.dart';

class Rect42 extends StatelessWidget {
  final int count;

  const Rect42({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RectangleBloc(count)
        ..add(
          LoadRectangle(const [], count),
        ),
      child: BlocBuilder<RectangleBloc, RectangleState>(
        builder: (context, state) {
          if (state is RectangleInitial) {
            return const CircularProgressIndicator();
          }

          if (state is RectangleLoaded) {
            return Scaffold(
              body: ListView.builder(
                itemCount: state.tiles.length,
                itemBuilder: (context, int index) {
                  final track = state.tiles[index];
                  final containerRow = Dismissible(
                    key: UniqueKey(),
                    background: ColoredBox(
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
                      height: 60,
                      color: track,
                    ),
                    onDismissed: (direction) {
                      context
                          .read<RectangleBloc>()
                          .add(ChangeRectangle(track, index));
                    },
                  );

                  Draggable draggable = LongPressDraggable(
                    data: track,
                    axis: Axis.vertical,
                    feedback: Material(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width),
                        child: containerRow,
                      ),
                    ),
                    child: containerRow,
                  );
                  return DragTarget<Color>(
                    onWillAccept: (track) {
                      return state.tiles.indexOf(track!) != index;
                    },
                    onAccept: (track) {
                      context
                          .read<RectangleBloc>()
                          .add(MoveRectangle(track, index));
                    },
                    builder: (context, List candidateData,
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
                            child: candidateData.isEmpty
                                ? draggable
                                : containerRow,
                          )
                        ],
                      );
                    },
                  );
                },
              ),
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
