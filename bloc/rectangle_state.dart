// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'rectangle_bloc.dart';

abstract class RectangleState {
  const RectangleState();
}

class RectangleInitial extends RectangleState {}

class RectangleLoaded extends RectangleState {
  final List<Color> tiles;

  const RectangleLoaded(this.tiles);
}
