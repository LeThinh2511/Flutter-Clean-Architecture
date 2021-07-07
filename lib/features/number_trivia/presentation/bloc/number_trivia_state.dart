import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/core/util/default_equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/number_trivia.dart';

@immutable
abstract class NumberTriviaState extends Equatable with DefaultEquatable {
  NumberTriviaState([List props = const <dynamic>[]]) : super();
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  Loaded(this.trivia) : super([trivia]);
}

class Error extends NumberTriviaState {
  final String message;

  Error(this.message) : super([message]);
}