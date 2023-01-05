part of 'rectangle_bloc.dart';

abstract class RectangleEvent {
  const RectangleEvent();
}

class LoadRectangle extends RectangleEvent {
  const LoadRectangle();
}

class MoveRectangle extends RectangleEvent {
  final RectangleImage image;
  final int index;

  const MoveRectangle(this.image, this.index);
}

class ChangeRectangle extends RectangleEvent {
  final RectangleImage image;
  final int index;

  const ChangeRectangle(this.image, this.index);
}
