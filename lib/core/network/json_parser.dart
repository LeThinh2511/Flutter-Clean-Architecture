import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'coder.dart';

class ParserFailure extends Failure {}

abstract class JsonParser {
  Either<Failure, T> parse<T extends Codable>(Map<String, dynamic> json);
}

class ManualJsonParser implements JsonParser {
  @override
  Either<Failure, T> parse<T extends Codable>(Map<String, dynamic> json) {
    try {
      T result = JsonCoder<T>().decode(json);
      return Right(result);
    } on Exception catch (exception) {
      return Left(ParserFailure());
    }
  }
}