import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Serie extends Equatable {
  final String description;
  final int endYear;
  final int id;
  final String rating;
  final int startYear;
  final String title;

  Serie({
    @required this.description,
    @required this.endYear,
    @required this.id,
    @required this.rating,
    @required this.startYear,
    @required this.title,
  });

  @override
  List<Object> get props =>
      [description, endYear, id, rating, startYear, title];
}
