import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/faliures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/rectiangle_image.dart';
import '../../domain/repositories/rectangle_image_repository.dart';
import '../datasources/rectangle_image_local_data_source.dart';
import '../datasources/rectangle_image_remote_data_source.dart';

class RectangleImageRepositoryImpl implements RectangleImageRepository {
  final RectangleImageRemoteDataSource remoteDataSource;
  final RectangleImageLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RectangleImageRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Faliure, List<RectangleImage>>> getRectangleImageList(
      int count) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteImage = await remoteDataSource.getRectangleImageList(count);
        localDataSource.cacheRectangleImage(remoteImage);
        return right(remoteImage);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      try {
        final localImage = await localDataSource.getLastRectangleImage();
        return right(localImage);
      } on CacheException {
        return Left(CacheFaliure());
      }
    }
  }

  @override
  Future<Either<Faliure, RectangleImage>> getRandomRectangleImage() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteImage = await remoteDataSource.getRandomRectangleImage();
        localDataSource.cacheRandomRectangleImage(remoteImage);
        return right(remoteImage);
      } on ServerException {
        return Left(ServerFaliure());
      }
    } else {
      try {
        final localImage = await localDataSource.getLastRandomRectangleImage();
        return right(localImage);
      } on CacheException {
        return Left(CacheFaliure());
      }
    }
  }
}
