import 'dart:math';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

part 'rectangle_event.dart';
part 'rectangle_state.dart';

class RectangleBloc extends Bloc<RectangleEvent, RectangleState> {
  final int count;

  RectangleBloc(this.count) : super(RectangleInitial()) {
    List<Color> tile = List.generate(count,
        (index) => Colors.primaries[Random().nextInt(Colors.primaries.length)]);
    on<LoadRectangle>(
      (event, emit) {
        emit(RectangleLoaded(tile));
      },
    );

    on<MoveRectangle>(
      (event, emit) {
        final state = this.state;
        if (state is RectangleLoaded) {
          final track = event.track;
          final index = event.index;
          int currentIndex = state.tiles.indexOf(track);
          state.tiles.remove(track);
          state.tiles.insert(currentIndex > index ? index : index - 1, track);
          emit(RectangleLoaded(List.from(state.tiles)));
        }
      },
    );

    on<ChangeRectangle>(
      (event, emit) {
        final state = this.state;
        if (state is RectangleLoaded) {
          final track = event.track;
          int currentIndex = state.tiles.indexOf(track);
          state.tiles.remove(track);
          state.tiles.insert(currentIndex,
              Colors.primaries[Random().nextInt(Colors.primaries.length)]);
          emit(RectangleLoaded(state.tiles));
        }
      },
    );
  }
}
