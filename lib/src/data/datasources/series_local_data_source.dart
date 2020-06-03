import 'package:marvel_series/src/data/models/serie.model.dart';

abstract class SeriesLocalDataSource {
  Future<List<SerieModel>> getLastSeries();

  Future cacheSeries(List<SerieModel> serieToCache);
}
