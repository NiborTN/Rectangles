import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:the_boxesv3/features/rectangles/data/repositories/rectangle_image_repository_impl.dart';

import 'core/network/network_info.dart';
import 'features/rectangles/data/datasources/rectangle_image_local_data_source.dart';
import 'features/rectangles/data/datasources/rectangle_image_remote_data_source.dart';

import 'features/rectangles/domain/usecases/get_random_rectange_image.dart';
import 'features/rectangles/domain/usecases/get_rectangle_image_list.dart';
import 'features/rectangles/presentation/bloc/rectangle_imports.dart';

final sl = GetIt.instance;

@override
Future<void> init() async {
  //! Features - Rectangle Image
  //Bloc
  sl.registerFactory<RectangleBloc>((() => RectangleBloc(
        getRandomRectangleImage: sl(),
        getRectangleImageList: sl(),
        count: sl(),
      )));

  //Use cases
  sl.registerLazySingleton(() => GetRectangleImageList(sl()));
  sl.registerLazySingleton(() => GetRandomRectangleImage(sl()));
  //presentation

  //Repository
  sl.registerLazySingleton<RectangleImageRepositoryImpl>(() =>
      RectangleImageRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //data source
  sl.registerLazySingleton<RectangleImageRemoteDataSource>(
      () => RectangleImageRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<RectangleImageLocalDataSource>(
      () => RectangleImageLocalDataSourceImpl(sharedPreferences: sl()));
  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  sl.registerSingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
