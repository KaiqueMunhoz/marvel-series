import 'package:marvel_series/features/series/data/models/serie.model.dart';

abstract class SeriesLocalDataSource {
  Future<List<SerieModel>> getLastSeries();

  Future cacheSeries(List<SerieModel> serieToCache);
}
