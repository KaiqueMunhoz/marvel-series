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
  SeriesLoaded({@required this.series});

  @override
  List<Object> get props => [series];
}

class SeriesError extends SeriesState {
  final String message;
  SeriesError({@required this.message});

  @override
  List<Object> get props => [message];
}
