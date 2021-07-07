import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/core/util/default_equatable.dart';

abstract class Failure extends Equatable with DefaultEquatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  Failure([List properties = const <dynamic>[]]): super();
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}