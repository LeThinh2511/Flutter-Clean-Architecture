import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<Either<Failure, NumberTriviaModel>> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  NumberTriviaLocalDataSourceImpl(this.sharedPreferences);

  static const String _key = 'CACHED_NUMBER_TRIVIA';
  final SharedPreferences sharedPreferences;

  @override
  Future<Either<Failure, NumberTriviaModel>> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(_key);
    if (jsonString != null) {
      return Future.value(Right(NumberTriviaModel.fromJson(json.decode(jsonString))));
    } else {
      return Future.value(Left(CacheFailure()));
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
      _key,
      json.encode(triviaToCache.toJson()),
    );
  }
}