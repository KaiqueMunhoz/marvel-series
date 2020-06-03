import 'package:dartz/dartz.dart';
import 'package:marvel_series/core/error/failures.dart';
import 'package:marvel_series/features/series/domain/entities/series.dart';
import 'package:marvel_series/features/series/domain/repositories/series.repo.dart';

class GetSeries {
  final SeriesRepo repository;

  GetSeries(this.repository);

  Future<Either<Failure, List<Serie>>> call() async {
    return await repository.getSeries();
  }
}
