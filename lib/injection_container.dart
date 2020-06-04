import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_series/core/network/network_info.dart';
import 'package:marvel_series/features/series/data/datasources/series_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/series/data/datasources/series_remote_data_source.dart';
import 'features/series/data/repositories/series.repo.impl.dart';
import 'features/series/domain/repositories/series.repo.dart';
import 'features/series/domain/usecases/get_series.dart';
import 'features/series/presentation/bloc/series_bloc.dart';

final sl = GetIt.instance;

void _initFeatures() {
  // Bloc
  sl.registerFactory(
    () => SeriesBloc(getSeries: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetSeries(sl()));

  // Repository
  sl.registerLazySingleton<SeriesRepo>(
    () => SeriesRepoImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<SeriesRemoteDataSource>(
    () => SeriesRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<SeriesLocalDataSource>(
    () => SeriesLocalDataSourceImpl(sharedPreferences: sl()),
  );
}

Future<void> _initExternal() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}

_initCore() {
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );
}

Future<void> init() async {
  _initFeatures();
  await _initExternal();
  _initCore();
}
