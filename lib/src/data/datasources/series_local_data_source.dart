import 'package:marvel_series/src/data/models/serie.mode.dart';

abstract class SeriesLocalDataSource {
  Future<List<SerieModel>> getLastSeries();

  Future cacheSeries(List<SerieModel> serieToCache);
}
