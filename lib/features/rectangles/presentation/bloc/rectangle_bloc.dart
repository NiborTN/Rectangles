// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_boxesv3/core/error/faliures.dart';
import 'package:the_boxesv3/core/usecases/usecase.dart';
import 'package:the_boxesv3/features/rectangles/domain/entities/rectiangle_image.dart';
import 'package:the_boxesv3/features/rectangles/domain/usecases/get_random_rectange_image.dart';

import '../../domain/usecases/get_rectangle_image_list.dart';

part 'rectangle_event.dart';
part 'rectangle_state.dart';

// ignore: constant_identifier_names
const String SERVER_FALIURE_MESSAGE = 'server faliure';
// ignore: constant_identifier_names
const String CACHE_FALIURE_MESSAGE = 'cache faliure';

class RectangleBloc extends Bloc<RectangleEvent, RectangleState> {
  final GetRectangleImageList getRectangleImageList;
  final GetRandomRectangleImage getRandomRectangleImage;
  final int count;

  RectangleBloc(
      {required this.getRandomRectangleImage,
      required this.count,
      required this.getRectangleImageList})
      : super(RectangleInitial()) {
    on<LoadRectangle>((event, emit) async {
      emit(const RectangleLoading());
      final faliureOrRectangle =
          await getRectangleImageList(Params(count: count));
      emit(faliureOrRectangle.fold(
          (faliure) => Error(message: _mapFailureToMessage(faliure)),
          (image) => RectangleLoaded(imageList: image)));
    });

    on<MoveRectangle>((event, emit) async {
      final state = this.state;
      if (state is RectangleLoaded) {
        final image = event.image;
        final index = event.index;
        int currentIndex = state.imageList.indexOf(image);
        state.imageList.remove(image);
        state.imageList.insert(currentIndex > index ? index : index - 1, image);
        emit(RectangleLoaded(imageList: List.from(state.imageList)));
      }
    });

    on<ChangeRectangle>(
      (event, emit) async {
        final state = this.state;
        if (state is RectangleLoaded) {
          final image = event.image;
          int currentIndex = state.imageList.indexOf(image);
          state.imageList.remove(image);
          emit(const RectangleLoading());
          final newImage = await getRandomRectangleImage(NoParams());
          emit(newImage
              .fold((faliure) => Error(message: _mapFailureToMessage(faliure)),
                  (image) {
            state.imageList.insert(currentIndex, image);
            return RectangleLoaded(imageList: List.from(state.imageList));
          }));
        }
      },
    );
  }
}

String _mapFailureToMessage(Faliure faliure) {
  switch (faliure.runtimeType) {
    case ServerFaliure:
      return SERVER_FALIURE_MESSAGE;
    case CacheFaliure:
      return CACHE_FALIURE_MESSAGE;
    default:
      return 'UNEXPRECTED_ERROR';
  }
}
