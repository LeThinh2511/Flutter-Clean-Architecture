import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_client.dart';
import 'core/network/network_info.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'features/number_trivia/presentation/util/input_converter.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  //Bloc
  serviceLocator.registerFactory<NumberTriviaBloc>(
          () => NumberTriviaBloc(serviceLocator(), serviceLocator(), serviceLocator())
  );

  // Use cases
  serviceLocator.registerLazySingleton(() => GetConcreteNumberTrivia(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetRandomNumberTrivia(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(serviceLocator(), serviceLocator(), serviceLocator()));

  // Data sources
  serviceLocator.registerLazySingleton<NumberTriviaRemoteDataSource>(
        () => NumberTriviaRemoteDataSourceImpl(client: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<NumberTriviaLocalDataSource>(
        () => NumberTriviaLocalDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => InputConverter());

  //! Core
  serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => NetworkClientImpl());
}
