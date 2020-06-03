import 'package:dartz/dartz.dart';
import 'package:marvel_series/src/core/error/failures.dart';
import 'package:marvel_series/src/domain/entities/series.dart';
import 'package:marvel_series/src/domain/repositories/series.repo.dart';

class SeriesList {
  final SeriesRepo repository;

  SeriesList(this.repository);

  Future<Either<Failure, List<Serie>>> call() async {
    return await repository.seriesList();
  }
}
