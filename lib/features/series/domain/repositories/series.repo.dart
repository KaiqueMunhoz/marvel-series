import 'package:dartz/dartz.dart';
import 'package:marvel_series/core/error/failures.dart';
import 'package:marvel_series/features/series/domain/entities/serie.dart';

abstract class SeriesRepo {
  Future<Either<Failure, List<Serie>>> getSeries();
}
