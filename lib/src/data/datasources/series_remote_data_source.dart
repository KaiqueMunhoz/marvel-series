import 'package:marvel_series/src/data/models/serie.mode.dart';

abstract class SeriesRemoteDataSource {
  Future<List<SerieModel>> seriesList();
}
