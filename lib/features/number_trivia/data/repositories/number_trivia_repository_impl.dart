import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/exception.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/core/network/network_info.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef GetRemoteNumberTrivia = Future<Either<Failure, NumberTriviaModel>>Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number,
      ) {
    return _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    return _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      GetRemoteNumberTrivia getRemoteNumberTrivia,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await getRemoteNumberTrivia();
        result.fold((failure) {
          return Left(failure);
        }, (remoteTrivia) {
          localDataSource.cacheNumberTrivia(remoteTrivia);
          return Right(remoteTrivia);
        });
        return Left(ServerFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
        return localDataSource.getLastNumberTrivia();
    }
  }
}