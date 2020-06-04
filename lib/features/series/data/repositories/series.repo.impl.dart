import 'package:dartz/dartz.dart';
import 'package:marvel_series/core/error/failures.dart';
import 'package:marvel_series/core/error/exceptions.dart';
import 'package:marvel_series/core/network/network_info.dart';
import 'package:marvel_series/features/series/data/datasources/series_local_data_source.dart';
import 'package:marvel_series/features/series/data/datasources/series_remote_data_source.dart';
import 'package:marvel_series/features/series/domain/entities/serie.dart';
import 'package:marvel_series/features/series/domain/repositories/series.repo.dart';
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
  Future<Either<Failure, List<Serie>>> getSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSeries = await remoteDataSource.getSeries();
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
