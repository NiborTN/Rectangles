import 'package:the_boxesv3/features/rectangles/domain/entities/rectiangle_image.dart';

class RectangleImageModel extends RectangleImage {
  final int id;
  final String url;

  const RectangleImageModel({
    required this.id,
    required this.url,
  }) : super(id: id, url: url);

  @override
  List<Object?> get props => [id, url];

  factory RectangleImageModel.fromJson(Map<String, dynamic> json) {
    return RectangleImageModel(id: json['id'], url: json['download_url']);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "download_url": url};
  }
}
