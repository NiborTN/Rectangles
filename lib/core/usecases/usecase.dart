import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:the_boxesv3/core/error/faliures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Faliure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
