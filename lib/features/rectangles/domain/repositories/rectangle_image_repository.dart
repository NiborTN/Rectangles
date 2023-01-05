// ignore: file_names
import 'package:dartz/dartz.dart';
import '../../../../core/error/faliures.dart';
import '../entities/rectiangle_image.dart';

abstract class RectangleImageRepository {
  Future<Either<Faliure, RectangleImage>> getRandomRectangleImage();
  Future<Either<Faliure, List<RectangleImage>>> getRectangleImageList(int count);
}
