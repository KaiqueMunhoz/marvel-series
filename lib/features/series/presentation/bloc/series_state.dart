part of 'series_bloc.dart';

abstract class SeriesState extends Equatable {
  const SeriesState();
}

class SeriesInitial extends SeriesState {
  @override
  List<Object> get props => [];
}

class SeriesLoading extends SeriesState {
  @override
  List<Object> get props => [];
}

class SeriesLoaded extends SeriesState {
  final List<Serie> series;
  SeriesLoaded(this.series);

  @override
  List<Object> get props => [series];
}
