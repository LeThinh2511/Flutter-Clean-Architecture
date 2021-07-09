import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/core/network/request_configuration.dart';

// Network client
abstract class NetworkClient {
  Future<Either<Failure, Map<String, dynamic>>> request(RequestConfiguration configuration);
}

class NetworkClientImpl implements NetworkClient {
  NetworkClientImpl();

  @override
  Future<Either<Failure, Map<String, dynamic>>> request(RequestConfiguration configuration) async {
    final Dio dio = Dio();
    print(configuration.method.rawValue);
    BaseOptions options = BaseOptions(
      method: configuration.method.rawValue,
      connectTimeout: configuration.connectTimeout,
      receiveTimeout: configuration.receiveTimeout,
      baseUrl: '${configuration.schema}://${configuration.host}',
      queryParameters: configuration.queryItems,
      headers: configuration.headers,
    );
    dio.options = options;

    var response = await dio.request(configuration.path, data: configuration.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.data);
      return Right(jsonData);
    } else {
      return Left(ServerFailure());
    }
  }
}