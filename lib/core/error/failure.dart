import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable with DefaultFailure {
  late final String message;
  late final String domain;
}

class DefaultFailure {
  final String message = 'Unexpected Error';
  final String domain = 'error.unknown';

  List<Object?> get props => [domain];
}

class ServerFailure extends Failure {
  ServerFailure({String? message, String code = 'unknown'}) {
    this.code = code;
    if (message != null) {
      this.message = message;
    }
    domain = 'error.server.$code';
  }

  late final String code;
}

class CacheFailure extends Failure {
  CacheFailure({String? message, String domain = 'unknown'}) {
    if (message != null) {
      this.message = message;
    }
    this.domain = 'error.cache.$domain';
  }
}
