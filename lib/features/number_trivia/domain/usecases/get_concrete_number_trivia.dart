import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia extends UseCase<NumberTrivia, Params> {
  GetConcreteNumberTrivia(this.repository);

  final NumberTriviaRepository repository;

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) {
    return repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  const Params(this.number);

  final int number;

  @override
  List<Object?> get props => [number];
}