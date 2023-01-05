import 'package:equatable/equatable.dart';

class RectangleImage extends Equatable {
  final int id;
  final url;

  const RectangleImage({
    required this.id,
    required this.url,
  });

  @override
  List<Object?> get props => [id, url];
}
