import 'package:dartz/dartz.dart';
import 'package:marvel_series/src/core/error/exceptions.dart';
import 'package:marvel_series/src/core/error/failures.dart';
import 'package:marvel_series/src/data/datasources/series_remote_data_source.dart';
import 'package:marvel_series/src/domain/entities/series.dart';
import 'package:marvel_series/src/domain/repositories/series.repo.dart';
import 'package:meta/meta.dart';

class SeriesRepoImpl implements SeriesRepo {
  final SeriesRemoteDataSource remoteDataSource;

  SeriesRepoImpl({
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Serie>>> seriesList() async {
    try {
      final remoteSeries = await remoteDataSource.seriesList();
      return Right(remoteSeries);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
