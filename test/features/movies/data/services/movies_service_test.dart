import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_db_app/core/network/network.dart';
import 'package:movie_db_app/features/movies/data/models/movie_details_model.dart';
import 'package:movie_db_app/features/movies/data/models/movie_model.dart';
import 'package:movie_db_app/features/movies/data/services/movies_service.dart';

import '../../../../mocks/models.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late Dio dio;
  late MoviesService service;

  setUp(() {
    dio = DioMock();
    service = MoviesServiceImpl(dio);
  });

  group('MoviesService tests...', () {
    group('on call getPopularMovies', () {
      test('returns list of MovieModel on success', () async {
        final mockJson = {
          ApiResponseKeys.results: [movieJsonMock],
        };

        when(
          () => dio.get(
            ApiRoutes.popularMovies,
            queryParameters: {ApiQueryParams.page: 1},
          ),
        ).thenAnswer(
          (_) async => Response(
            data: mockJson,
            statusCode: 200,
            requestOptions: RequestOptions(),
          ),
        );

        final result = await service.getPopularMovies(page: 1);

        expect(result, isA<List<MovieModel>>());
        expect(result.first.title, 'Test Movie');
      });

      test('throws NetworkException on DioException', () async {
        when(
          () => dio.get(any(), queryParameters: any(named: 'queryParameters')),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            error: 'No Internet',
            message: 'Network unreachable',
          ),
        );
        expect(
          () async => await service.getPopularMovies(page: 1),
          throwsA(isA<NetworkException>()),
        );
      });

      test('throws Failure on generic error', () async {
        when(
          () => dio.get(any(), queryParameters: any(named: 'queryParameters')),
        ).thenThrow(Exception('Generic error'));

        expect(
          () async => await service.getPopularMovies(page: 1),
          throwsA(isA<Failure>()),
        );
      });
    });

    group('on call getMovieDetails', () {
      test('returns MovieDetailsModel on success', () async {
        when(() => dio.get(ApiRoutes.movieDetails(1))).thenAnswer(
          (_) async => Response(
            data: movieDetailsJsonMock,
            statusCode: 200,
            requestOptions: RequestOptions(),
          ),
        );

        final result = await service.getMovieDetails(movieId: 1);

        expect(result, isA<MovieDetailsModel>());
        expect(result.title, 'Test Movie');
      });

      test('throws ServerException on DioException', () async {
        when(() => dio.get(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/movie/1'),
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 500,
              data: 'Internal Server Error',
              requestOptions: RequestOptions(path: '/movie/1'),
            ),
          ),
        );

        expect(
          () async => await service.getMovieDetails(movieId: 1),
          throwsA(isA<ServerException>()),
        );
      });

      test('throws Failure on generic error', () async {
        when(() => dio.get(any())).thenThrow(Exception('Something went wrong'));

        expect(
          () async => await service.getMovieDetails(movieId: 1),
          throwsA(isA<Failure>()),
        );
      });
    });
  });
}
