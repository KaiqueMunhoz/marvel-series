import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_series/core/error/exceptions.dart';
import 'package:marvel_series/features/series/data/datasources/series_local_data_source.dart';
import 'package:marvel_series/features/series/data/models/serie.model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  SeriesLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        SeriesLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group("getLastSeries", () {
    final String fixturePath = 'serie_cached.json';
    final tSeriesModel = SerieModel.fromJson(json.decode(fixture(fixturePath)));
    test(
      'should return series from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture(fixturePath));
        // act
        final result = await dataSource.getLastSeries();
        // assert
        verify(mockSharedPreferences.getString(CACHED_SERIES));
        expect(result, [tSeriesModel]);
      },
    );
    test(
      'should throw a CacheException when there is not a cached value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getLastSeries;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheSeries', () {
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

    test(
      'should call SharedPreferences to cache the data',
      () async {
        // arrange
        final seriesToCacheJson =
            tSerieModel.map((serie) => serie.toJson()).toList();
        // act
        dataSource.cacheSeries(tSerieModel);
        // assert
        final expected = json.encode(seriesToCacheJson);
        verify(mockSharedPreferences.setString(CACHED_SERIES, expected));
      },
    );
  });
}
