import 'package:get_it/get_it.dart';
import 'package:marvel_series/src/blocs/series/series_bloc.dart';
import 'package:marvel_series/src/data/datasources/series_remote_data_source.dart';
import 'package:marvel_series/src/data/repositories/series.repo.impl.dart';
import 'package:marvel_series/src/domain/repositories/series.repo.dart';
import 'package:marvel_series/src/domain/usecases/series_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void _initFeatures() {
  // Bloc
  sl.registerFactory(
    () => SeriesBloc(seriesList: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SeriesList(sl()));

  // Repository
  sl.registerLazySingleton<SeriesRepo>(
    () => SeriesRepoImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SeriesRemoteDataSource>(
    () => SeriesRemoteDataSourceImpl(client: sl()),
  );
}

Future<void> _initExternal() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
}

Future<void> init() async {
  _initFeatures();
  await _initExternal();
}
