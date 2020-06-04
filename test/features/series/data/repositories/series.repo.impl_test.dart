import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_series/core/error/exceptions.dart';
import 'package:marvel_series/core/error/failures.dart';
import 'package:marvel_series/core/network/network_info.dart';
import 'package:marvel_series/features/series/data/datasources/series_local_data_source.dart';
import 'package:marvel_series/features/series/data/datasources/series_remote_data_source.dart';
import 'package:marvel_series/features/series/data/models/serie.model.dart';
import 'package:marvel_series/features/series/data/repositories/series.repo.impl.dart';
import 'package:marvel_series/features/series/domain/entities/serie.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements SeriesRemoteDataSource {}

class MockLocalDataSource extends Mock implements SeriesLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  final tSerieModel = [
    SerieModel(
      description: null,
      endYear: 2019,
      id: 28292,
      rating: "",
      startYear: 2019,
      title: " Future Fight Firsts: Crescent and Io (2019)",
    )
  ];

  final tSerie = tSerieModel;

  SeriesRepoImpl repository;

  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = SeriesRepoImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group("getSeries", () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getSeries();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );
  });

  group("device is online", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test(
      'should return remote data when the call to remote data source is success',
      () async {
        // arrange
        when(mockRemoteDataSource.seriesList())
            .thenAnswer((_) async => tSerieModel);
        // act
        final result = await repository.getSeries();
        // assert
        expect(result, Right(tSerie));
      },
    );
    test(
      'should cache the data locally when the call to remote data source is success',
      () async {
        // arrange
        when(mockRemoteDataSource.seriesList())
            .thenAnswer((_) async => tSerieModel);
        // act
        final result = await repository.getSeries();
        // assert
        expect(result, Right(tSerie));
        verify(mockLocalDataSource.cacheSeries(tSerieModel));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.seriesList()).thenThrow(ServerException());
        // act
        final result = await repository.getSeries();
        // assert
        expect(result, Left(ServerFailure()));
      },
    );
  });
  group("device is offline", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    test(
      'should return last locally cached data when the cached data is present',
      () async {
        // arrange
        when(mockLocalDataSource.getLastSeries())
            .thenAnswer((_) async => tSerieModel);
        // act
        final result = await repository.getSeries();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastSeries());
        expect(result, Right(tSerie));
      },
    );
    test(
      'should return CacheFailure when there is no cached data present',
      () async {
        // arrange
        when(mockLocalDataSource.getLastSeries()).thenThrow(CacheException());
        // act
        final result = await repository.getSeries();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastSeries());
        expect(result, Left(CacheFailure()));
      },
    );
  });
}
