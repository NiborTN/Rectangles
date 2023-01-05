// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'rectangle_bloc.dart';

abstract class RectangleState {
  const RectangleState();
}

class RectangleInitial extends RectangleState {}

class RectangleLoading extends RectangleState {
  const RectangleLoading();
}

class RectangleLoaded extends RectangleState {
  final List<RectangleImage> imageList;

  const RectangleLoaded({required this.imageList});
}

class Error extends RectangleState {
  final String message;

  const Error({required this.message});
}
