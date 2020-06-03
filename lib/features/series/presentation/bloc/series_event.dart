part of 'series_bloc.dart';

abstract class SeriesEvent extends Equatable {
  const SeriesEvent();
}

class GetSeriesList extends SeriesEvent {
  @override
  List<Object> get props => null;
}
