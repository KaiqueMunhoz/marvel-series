import 'package:dartz/dartz.dart';
import 'package:marvel_series/src/core/error/exceptions.dart';
import 'package:marvel_series/src/core/error/failures.dart';
import 'package:marvel_series/src/core/platform/network_info.dart';
import 'package:marvel_series/src/data/datasources/series_local_data_source.dart';
import 'package:marvel_series/src/data/datasources/series_remote_data_source.dart';
import 'package:marvel_series/src/domain/entities/series.dart';
import 'package:marvel_series/src/domain/repositories/series.repo.dart';
import 'package:meta/meta.dart';

class SeriesRepoImpl implements SeriesRepo {
  final SeriesRemoteDataSource remoteDataSource;
  final SeriesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SeriesRepoImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Serie>>> seriesList() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSeries = await remoteDataSource.seriesList();
        localDataSource.cacheSeries(remoteSeries);
        return Right(remoteSeries);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localSerie = await localDataSource.getLastSeries();
        return Right(localSerie);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
