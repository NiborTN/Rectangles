import 'package:dartz/dartz.dart';
import 'package:the_boxesv3/core/usecases/usecase.dart';
import '../../../../core/error/faliures.dart';
import '../../data/repositories/rectangle_image_repository_impl.dart';
import '../entities/rectiangle_image.dart';

class GetRandomRectangleImage implements UseCase<RectangleImage, NoParams> {
  // ignore: prefer_typing_uninitialized_variables
  final RectangleImageRepositoryImpl repository;

  GetRandomRectangleImage(this.repository);

  @override
  Future<Either<Faliure, RectangleImage>> call(NoParams params) async {
    return await repository.getRandomRectangleImage();
  }
}
