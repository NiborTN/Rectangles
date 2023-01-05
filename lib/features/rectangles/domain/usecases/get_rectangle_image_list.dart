import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:the_boxesv3/core/usecases/usecase.dart';
import 'package:the_boxesv3/features/rectangles/data/repositories/rectangle_image_repository_impl.dart';
import 'package:the_boxesv3/features/rectangles/domain/entities/rectiangle_image.dart';

import '../../../../core/error/faliures.dart';

class GetRectangleImageList implements UseCase<List<RectangleImage>, Params> {
  // ignore: prefer_typing_uninitialized_variables
  final RectangleImageRepositoryImpl repository;

  GetRectangleImageList(this.repository);

  @override
  Future<Either<Faliure, List<RectangleImage>>> call(Params params) async {
    return await repository.getRectangleImageList(params.count);
  }
}

class Params extends Equatable {
  final int count;

  const Params({required this.count});

  @override
  List<Object?> get props => [count];
}
