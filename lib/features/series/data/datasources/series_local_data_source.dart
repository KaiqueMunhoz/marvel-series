import 'dart:convert';

import 'package:marvel_series/core/error/exceptions.dart';
import 'package:marvel_series/features/series/data/models/serie.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class SeriesLocalDataSource {
  Future<List<SerieModel>> getLastSeries();

  Future cacheSeries(List<SerieModel> serieToCache);
}

const CACHED_SERIES = 'CACHED_SERIES';

class SeriesLocalDataSourceImpl implements SeriesLocalDataSource {
  final SharedPreferences sharedPreferences;

  SeriesLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheSeries(List<SerieModel> seriesToCache) {
    final seriesToCacheJson =
        seriesToCache.map((serie) => serie.toJson()).toList();
    return sharedPreferences.setString(
      CACHED_SERIES,
      json.encode(seriesToCacheJson),
    );
  }

  @override
  Future<List<SerieModel>> getLastSeries() {
    final jsonString = sharedPreferences.getString(CACHED_SERIES);
    if (jsonString != null) {
      return Future.value([SerieModel.fromJson(json.decode(jsonString))]);
    } else {
      throw CacheException();
    }
  }
}
