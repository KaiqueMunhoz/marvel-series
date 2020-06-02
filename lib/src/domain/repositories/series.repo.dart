import 'package:dartz/dartz.dart';
import 'package:marvel_series/src/core/error/failures.dart';
import 'package:marvel_series/src/domain/entities/series.dart';

abstract class SeriesRepo {
  Future<Either<Failure, List<Serie>>> seriesList();
}
