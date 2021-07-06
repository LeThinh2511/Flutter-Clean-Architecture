import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia {
  final NumberTriviaRepository repository;

  const GetRandomNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return repository.getRandomNumberTrivia();
  }
}