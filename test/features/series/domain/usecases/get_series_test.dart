import 'package:dartz/dartz.dart';
import 'package:marvel_series/core/usecases/usecases.dart';
import 'package:marvel_series/features/series/domain/entities/series.dart';
import 'package:marvel_series/features/series/domain/repositories/series.repo.dart';
import 'package:marvel_series/features/series/domain/usecases/get_series.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSeriesRepo extends Mock implements SeriesRepo {}

void main() {
  GetSeries usecase;
  MockSeriesRepo mockSeriesRepo;

  setUp(() {
    mockSeriesRepo = MockSeriesRepo();
    usecase = GetSeries(mockSeriesRepo);
  });

  final series = List<Serie>();

  test(
    'should get a list of series from the repository',
    () async {
      // arrange
      when(mockSeriesRepo.getSeries()).thenAnswer((_) async => Right(series));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(series));
      verify(mockSeriesRepo.getSeries());
      verifyNoMoreInteractions(mockSeriesRepo);
    },
  );
}
