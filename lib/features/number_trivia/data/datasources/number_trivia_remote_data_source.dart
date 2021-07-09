import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/core/network/network_client.dart';
import 'package:flutter_clean_architecture/core/network/request_configuration.dart';
import 'package:flutter_clean_architecture/core/error/exception.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Either<Failure, NumberTriviaModel>> getConcreteNumberTrivia(
      int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Either<Failure, NumberTriviaModel>> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final NetworkClient client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, NumberTriviaModel>> getConcreteNumberTrivia(
      int number) {
    var config = DefaultRequestConfiguration();
    config.path = '/$number';
    return _getTriviaFromUrl(config);
  }

  @override
  Future<Either<Failure, NumberTriviaModel>> getRandomNumberTrivia() {
    var config = DefaultRequestConfiguration();
    config.path = '/random';
    return _getTriviaFromUrl(config);
  }

  Future<Either<Failure, NumberTriviaModel>> _getTriviaFromUrl(
      RequestConfiguration config) async {
    final response = await client.request(config);
    response.fold((failure) {
      return Left(failure);
    }, (json) {
      return Right(NumberTriviaModel.fromJson(json));
    });
    return Left(ServerFailure());
  }
}
