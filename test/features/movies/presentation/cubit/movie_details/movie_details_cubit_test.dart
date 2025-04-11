import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_db_app/core/network/exceptions.dart';
import 'package:movie_db_app/features/movies/data/services/movies_service.dart';
import 'package:movie_db_app/features/movies/presentation/cubit/movie_details/movie_details_cubit.dart';

import '../../../../../mocks/models.dart';
import '../../../../../mocks/services.dart';

void main() {
  late MoviesService moviesServiceMock;
  late MovieDetailsCubit movieDetailsCubit;

  setUp(() {
    moviesServiceMock = MoviesServiceMock();
    movieDetailsCubit = MovieDetailsCubit(service: moviesServiceMock);
  });

  tearDown(() {
    movieDetailsCubit.close();
  });

  group('MovieDetailsCubit tests...', () {
    test('initial state is MovieDetailsState.initial()', () {
      expect(movieDetailsCubit.state, MovieDetailsState.initial());
    });

    blocTest<MovieDetailsCubit, MovieDetailsState>(
      'emits [loading, success] when getMovieDetails is called with success',
      build: () => movieDetailsCubit,
      act: (cubit) {
        when(
          () => moviesServiceMock.getMovieDetails(movieId: 1),
        ).thenAnswer((_) async => movieDetailsMock);
        cubit.getMovieDetails(movieId: 1);
      },
      expect:
          () => [
            MovieDetailsState.initial().copyWith(
              status: MovieDetailsStatus.loading,
            ),
            MovieDetailsState.initial().copyWith(
              status: MovieDetailsStatus.success,
              movie: movieDetailsMock,
            ),
          ],
    );

    blocTest<MovieDetailsCubit, MovieDetailsState>(
      'emits [loading, failure] when getMovieDetails throws an exception',
      build: () => movieDetailsCubit,
      act: (cubit) {
        when(
          () => moviesServiceMock.getMovieDetails(movieId: 1),
        ).thenThrow(ServerException());
        cubit.getMovieDetails(movieId: 1);
      },
      expect:
          () => [
            MovieDetailsState.initial().copyWith(
              status: MovieDetailsStatus.loading,
            ),
            MovieDetailsState.initial().copyWith(
              status: MovieDetailsStatus.failure,
            ),
          ],
    );
  });
}
