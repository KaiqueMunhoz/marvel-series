import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_series/core/network/http.dart';
import 'package:marvel_series/features/series/data/datasources/series_remote_data_source.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient;
  SeriesRemoteDataSourceImpl dataSource;
  final String fixturePath = 'serie.json';
  const String seriesUrl = "/v1/public/series";

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group("getSeries", () {
    test(
      'should perform a GET request on a URL with application/json in header',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(fixture(fixturePath), 200));
        // act
        await dataSource.getSeries();
        // assert
        verify(mockHttpClient.get(
          Http.url(seriesUrl),
          headers: {'content-type': 'application/json'},
        ));
      },
    );
  });
}
