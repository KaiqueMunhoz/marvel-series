import 'dart:convert';

import 'package:marvel_series/core/network/http.dart';
import 'package:marvel_series/features/series/data/models/serie.model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

const String seriesUrl = "/v1/public/series";

abstract class SeriesRemoteDataSource {
  Future<List<SerieModel>> seriesList();
}

class SeriesRemoteDataSourceImpl implements SeriesRemoteDataSource {
  final http.Client client;
  final url = Http.url(seriesUrl);

  SeriesRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<List<SerieModel>> seriesList() async {
    final response = await client.get(url, headers: Http.headers);
    Map<String, dynamic> data = json.decode(response.body);
    return ResponseSerieModel.fromJson(data).data.results;
  }
}
