import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_series/core/error/failures.dart';
import 'package:marvel_series/core/usecases/usecases.dart';
import 'package:marvel_series/features/series/data/models/serie.model.dart';
import 'package:marvel_series/features/series/domain/usecases/get_series.dart';
import 'package:marvel_series/features/series/presentation/bloc/series_bloc.dart';
import 'package:mockito/mockito.dart';

class MockGetSeries extends Mock implements GetSeries {}

void main() {
  MockGetSeries mockGetSeries;
  SeriesBloc bloc;
  final tSerieModel = [
    SerieModel(
      description: null,
      endYear: 2019,
      id: 28292,
      rating: "",
      startYear: 2019,
      title: " Future Fight Firsts: Crescent and Io (2019)",
    )
  ];

  final tSerie = tSerieModel;

  setUp(() {
    mockGetSeries = MockGetSeries();
    bloc = SeriesBloc(getSeries: mockGetSeries);
  });

  test(
    'should be SeriesInitial() when was initial state',
    () async {
      // assert
      expect(bloc.initialState, SeriesInitial());
    },
  );

  group('getSeries', () {
    test(
      'should get data from GetSeries use case ',
      () async {
        // arrange
        when(mockGetSeries(any)).thenAnswer((_) async => Right(tSerie));
        // act
        bloc.add(GetSeriesList());
        await untilCalled(mockGetSeries(any));
        // assert
        verify(mockGetSeries(NoParams()));
      },
    );

    test(
      'should emit [SeriesInitial, SeriesLoading, SeriesLoaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetSeries(any)).thenAnswer((_) async => Right(tSerie));
        // act
        bloc.add(GetSeriesList());
        // assert later
        final expected = [
          SeriesInitial(),
          SeriesLoading(),
          SeriesLoaded(series: tSerie),
        ];
        expectLater(bloc, emitsInOrder(expected));
      },
    );
    test(
      'should emit [SeriesInitial, SeriesLoading, SeriesError] with a proper message for the error',
      () async {
        // arrange
        when(mockGetSeries(any)).thenAnswer((_) async => Left(ServerFailure()));
        // act
        bloc.add(GetSeriesList());
        // assert later
        final expected = [
          SeriesInitial(),
          SeriesLoading(),
          SeriesError(message: mapFailureToMessage(ServerFailure())),
        ];
        expectLater(bloc, emitsInOrder(expected));
      },
    );
  });

  tearDown(() {
    bloc.close();
  });
}
