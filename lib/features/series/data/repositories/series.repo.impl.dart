import 'package:dartz/dartz.dart';
import 'package:marvel_series/core/error/failures.dart';
import 'package:marvel_series/core/error/exceptions.dart';
import 'package:marvel_series/features/series/data/datasources/series_remote_data_source.dart';
import 'package:marvel_series/features/series/domain/entities/series.dart';
import 'package:marvel_series/features/series/domain/repositories/series.repo.dart';
import 'package:meta/meta.dart';

class SeriesRepoImpl implements SeriesRepo {
  final SeriesRemoteDataSource remoteDataSource;

  SeriesRepoImpl({
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Serie>>> getSeries() async {
    try {
      final remoteSeries = await remoteDataSource.seriesList();
      return Right(remoteSeries);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
