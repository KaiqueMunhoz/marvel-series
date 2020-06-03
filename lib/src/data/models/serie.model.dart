import 'package:marvel_series/src/domain/entities/series.dart';
import 'package:meta/meta.dart';

class Response {
  int code;
  String status;
  String copyright;
  String attributionText;
  String attributionHTML;
  String etag;
  Data data;

  Response({
    this.code,
    this.status,
    this.copyright,
    this.attributionText,
    this.attributionHTML,
    this.etag,
    this.data,
  });

  Response.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    copyright = json['copyright'];
    attributionText = json['attributionText'];
    attributionHTML = json['attributionHTML'];
    etag = json['etag'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['copyright'] = this.copyright;
    data['attributionText'] = this.attributionText;
    data['attributionHTML'] = this.attributionHTML;
    data['etag'] = this.etag;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int offset;
  int limit;
  int total;
  int count;
  List<SerieModel> results;

  Data({this.offset, this.limit, this.total, this.count, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      results = new List<SerieModel>();
      json['results'].forEach((v) {
        results.add(new SerieModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['count'] = this.count;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SerieModel extends Serie {
  SerieModel({
    @required String description,
    @required int endYear,
    @required int id,
    @required String rating,
    @required int startYear,
    @required String title,
  }) : super(
          description: description,
          endYear: endYear,
          id: id,
          rating: rating,
          startYear: startYear,
          title: title,
        );

  factory SerieModel.fromJson(Map<String, dynamic> json) {
    return SerieModel(
        description: json['description'],
        endYear: json['endYear'],
        id: json['id'],
        rating: json['rating'],
        startYear: json['startYear'],
        title: json['title']);
  }
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'endYear': endYear,
      'id': id,
      'rating': rating,
      'startYear': startYear,
      'title': title,
    };
  }
}
