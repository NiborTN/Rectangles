import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_boxesv3/core/error/exceptions.dart';
import '../models/rectangle_image_model.dart';

abstract class RectangleImageLocalDataSource {
  ///Gets the cached [RectangleImageModel] which was gotten the last time the user had as internet connection
  ///
  ///Throws [CacheException] if no cached data is present
  Future<List<RectangleImageModel>> getLastRectangleImage();
  Future<void> cacheRectangleImage(List<RectangleImageModel> imageToCache);
  Future<RectangleImageModel> getLastRandomRectangleImage();
  Future<void> cacheRandomRectangleImage(RectangleImageModel imageToCache);
}

const CACHED_RECTANGLE_IMAGE = 'CACHED_RECTANGLE_IMAGE';
const CACHED_RANDOM_RECTANGLE_IMAGE = 'CACHED_RANDOM_RECTANGLE_IMAGE';

class RectangleImageLocalDataSourceImpl
    implements RectangleImageLocalDataSource {
  late SharedPreferences sharedPreferences;

  RectangleImageLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<RectangleImageModel>> getLastRectangleImage() {
    final jsonString = sharedPreferences.getString(CACHED_RECTANGLE_IMAGE);
    if (jsonString != null) {
      List<RectangleImageModel> imageList = [];
      List jsonString2 = jsonDecode(jsonString);
      for (var i = 0; i < jsonString2.length; i++) {
        imageList.add(RectangleImageModel.fromJson(jsonString2[i]));
      }
      return Future.value(imageList);
    } else {
      throw (CacheException());
    }
  }

  @override
  Future<RectangleImageModel> getLastRandomRectangleImage() {
    final jsonString =
        sharedPreferences.getString(CACHED_RANDOM_RECTANGLE_IMAGE);
    if (jsonString != null) {
      return Future.value(RectangleImageModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw (CacheException());
    }
  }

  @override
  Future<void> cacheRectangleImage(List<RectangleImageModel> imageToCache) {
    List<Map<String, dynamic>> jsonList = [];
    for (var i = 0; i < imageToCache.length; i++) {
      jsonList.add(imageToCache[i].toJson());
    }

    return sharedPreferences.setString(
        CACHED_RECTANGLE_IMAGE, jsonEncode(jsonList));
  }

  @override
  Future<void> cacheRandomRectangleImage(RectangleImageModel imageToCache) {
    var jsonImage = imageToCache.toJson();
    return sharedPreferences.setString(
        CACHED_RANDOM_RECTANGLE_IMAGE, jsonEncode(jsonImage));
  }
}
