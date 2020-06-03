import 'package:dartz/dartz.dart';
import 'package:marvel_series/core/error/failures.dart';
import 'package:marvel_series/core/usecases/usecases.dart';
import 'package:marvel_series/features/series/domain/entities/series.dart';
import 'package:marvel_series/features/series/domain/repositories/series.repo.dart';

class GetSeries implements UseCase<List<Serie>, NoParams> {
  final SeriesRepo repository;

  GetSeries(this.repository);

  @override
  Future<Either<Failure, List<Serie>>> call(NoParams params) async {
    return await repository.getSeries();
  }
}
