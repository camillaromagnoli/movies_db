import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_db_app/core/network/network.dart';
import 'package:movie_db_app/features/movies/data/services/movies_service.dart';
import 'package:movie_db_app/features/movies/presentation/cubit/movies/movies_cubit.dart';

import '../../../../../mocks/models.dart';
import '../../../../../mocks/services.dart';

void main() {
  late MoviesService moviesServiceMock;
  late MoviesCubit moviesCubit;

  setUp(() {
    moviesServiceMock = MoviesServiceMock();

    moviesCubit = MoviesCubit(services: moviesServiceMock);
  });

  tearDown(() {
    moviesCubit.close();
  });

  group('MoviesCubit tests...', () {
    test('Initial state is MoviesState.initial()', () {
      expect(moviesCubit.state, MoviesState.initial());
    });

    blocTest<MoviesCubit, MoviesState>(
      'emits [loading, success] when getPopularMovies is called with isInitial = true',
      build: () => moviesCubit,
      act: (cubit) {
        when(
          () => moviesServiceMock.getPopularMovies(page: 1),
        ).thenAnswer((_) async => [movieModelMock]);
        cubit.getPopularMovies(isInitial: true);
      },
      expect:
          () => [
            MoviesState.initial().copyWith(status: MoviesStatus.loading),
            MoviesState.initial().copyWith(
              status: MoviesStatus.success,
              movies: [movieModelMock],
            ),
          ],
    );
  });
  blocTest<MoviesCubit, MoviesState>(
    'emits [isLoadingMore true, success, isLoadingMore false] when getPopularMovies is called with isInitial = false',
    build: () => moviesCubit,
    seed:
        () => MoviesState(
          status: MoviesStatus.success,
          movies: [],
          page: 1,
          isLoadingMore: false,
        ),
    act: (cubit) {
      when(
        () => moviesServiceMock.getPopularMovies(page: 1),
      ).thenAnswer((_) async => [movieModelMock]);

      cubit.getPopularMovies(isInitial: false);
    },
    expect:
        () => [
          MoviesState(
            status: MoviesStatus.success,
            movies: [],
            page: 1,
            isLoadingMore: true,
          ),
          MoviesState(
            status: MoviesStatus.success,
            movies: [movieModelMock],
            page: 2,
            isLoadingMore: true,
          ),
          MoviesState(
            status: MoviesStatus.success,
            movies: [movieModelMock],
            page: 2,
            isLoadingMore: false,
          ),
        ],
  );
  blocTest<MoviesCubit, MoviesState>(
    'emits [isLoadingMore true, failure, isLoadingMore false] when getPopularMovies throws an exception',
    build: () => moviesCubit,
    act: (cubit) {
      when(
        () => moviesServiceMock.getPopularMovies(page: 1),
      ).thenThrow((_) async => ServerException());
      cubit.getPopularMovies(isInitial: true);
    },
    expect:
        () => [
          MoviesState.initial().copyWith(status: MoviesStatus.loading),
          MoviesState.initial().copyWith(status: MoviesStatus.failure),
        ],
  );
}
