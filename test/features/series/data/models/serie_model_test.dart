import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_series/features/series/data/models/serie.model.dart';
import 'package:marvel_series/features/series/domain/entities/series.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tSerieModel = SerieModel(
    description: null,
    endYear: 2019,
    id: 28292,
    rating: "",
    startYear: 2019,
    title: " Future Fight Firsts: Crescent and Io (2019)",
  );

  test(
    'should be a subclass of Serie entity',
    () async {
      // assert
      expect(tSerieModel, isA<Serie>());
    },
  );

  group("fromJson", () {
    test(
      'should return a valid model when the JSON is called',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          fixture('serie.json'),
        );
        // act
        final response = ResponseSerieModel.fromJson(jsonMap);
        final responseSerie = response.data.results[0];
        // assert
        expect(responseSerie, tSerieModel);
      },
    );
  });

  group("toJson", () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // arrange
        final expectedMap = {
          "description": null,
          "endYear": 2019,
          "id": 28292,
          "rating": "",
          "startYear": 2019,
          "title": " Future Fight Firsts: Crescent and Io (2019)",
        };
        // act
        final result = tSerieModel.toJson();

        // assert
        expect(result, expectedMap);
      },
    );
  });
}
