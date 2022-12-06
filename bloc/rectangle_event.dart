part of 'rectangle_bloc.dart';

abstract class RectangleEvent {
  const RectangleEvent();
}

class LoadRectangle extends RectangleEvent {
  final List tiles;
  final int count;

  const LoadRectangle(this.tiles, this.count);
}

class MoveRectangle extends RectangleEvent {
  final Color track;
  final int index;

  const MoveRectangle(this.track, this.index);
}

class ChangeRectangle extends RectangleEvent {
  final Color track;
  final int index;

  const ChangeRectangle(this.track, this.index);
}
