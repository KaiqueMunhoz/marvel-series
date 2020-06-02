import 'package:marvel_series/src/domain/entities/series.dart';
import 'package:meta/meta.dart';

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
