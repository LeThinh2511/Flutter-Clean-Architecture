import 'package:flutter_clean_architecture/core/util/default_equatable.dart';
import 'package:equatable/equatable.dart';

class BaseState extends Equatable with DefaultEquatable {
  BaseState([List props = const <dynamic>[]]) : super();


}


class Empty extends BaseState {}

class Loading extends BaseState {}

class Loaded<T> extends BaseState {
  final T data;

  Loaded(this.data) : super([data]);
}

class Error extends BaseState {
  final String message;

  Error(this.message) : super([message]);
}