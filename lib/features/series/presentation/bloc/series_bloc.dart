import 'dart:async';

import 'package:marvel_series/features/series/domain/entities/series.dart';
import 'package:marvel_series/features/series/domain/usecases/get_series.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'series_event.dart';
part 'series_state.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final GetSeries getSeries;

  SeriesBloc({
    @required this.getSeries,
  });

  @override
  SeriesState get initialState => SeriesInitial();

  @override
  Stream<SeriesState> mapEventToState(
    SeriesEvent event,
  ) async* {
    yield SeriesLoading();
    if (event is GetSeriesList) {
      final failureOrSeries = await getSeries();
      yield* failureOrSeries.fold((failure) async* {}, (series) async* {
        yield SeriesLoaded(series);
      });
    }
  }
}
