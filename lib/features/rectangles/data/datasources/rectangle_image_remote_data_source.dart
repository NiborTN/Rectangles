import 'dart:convert';
import 'dart:math';

import 'package:the_boxesv3/core/error/exceptions.dart';
import 'package:the_boxesv3/features/rectangles/data/models/rectangle_image_model.dart';
import 'package:http/http.dart' as http;

abstract class RectangleImageRemoteDataSource {
  /// calls the https://picsum.photos/v2/list?limit={count} endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<List<RectangleImageModel>> getRectangleImageList(int count);
  Future<RectangleImageModel> getRandomRectangleImage();
}

class RectangleImageRemoteDataSourceImpl
    implements RectangleImageRemoteDataSource {
  final http.Client client;

  RectangleImageRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RectangleImageModel>> getRectangleImageList(int count) async {
    var url =
        Uri.https('picsum.photos', 'v2/list', {'limit': count.toString()});
    final response = await client.get(url);
    if (response.statusCode == 200) {
      List<RectangleImageModel> imageList = [];
      List body = jsonDecode(response.body);
      for (var i = 0; i < body.length; i++) {
        imageList.add(RectangleImageModel.fromJson(body[i]));
      }

      return Future.value(imageList);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RectangleImageModel> getRandomRectangleImage() async {
    final int randonId = Random().nextInt(100) + 50;
    var url = Uri.https('picsum.photos', 'id/$randonId/info');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return Future.value(
          RectangleImageModel.fromJson(jsonDecode(response.body)));
    } else {
      throw ServerException();
    }
  }
}
