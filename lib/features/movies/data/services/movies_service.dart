import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_db_app/core/network/api_response_keys.dart';
import 'package:movie_db_app/core/network/api_routes.dart';
import 'package:movie_db_app/core/network/exceptions.dart';
import 'package:movie_db_app/core/network/query_parameters.dart';
import 'package:movie_db_app/features/movies/data/models/movie_details_model.dart';
import 'package:movie_db_app/features/movies/data/models/movie_model.dart';

abstract class MoviesService {
  Future<List<MovieModel>> getPopularMovies({required int page});
  Future<MovieDetailsModel> getMovieDetails({required int movieId});
}

@LazySingleton(as: MoviesService)
class MoviesServiceImpl extends MoviesService {
  final Dio _dio;

  MoviesServiceImpl(this._dio);

  @override
  Future<List<MovieModel>> getPopularMovies({required int page}) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      List<MovieModel> movies = [];

      final Response response = await _dio.get(
        ApiRoutes.popularMovies,
        queryParameters: {ApiQueryParams.page: page},
      );

      final Map<String, dynamic> data = response.data;

      List moviesJson = data[ApiResponseKeys.results];

      for (var movie in moviesJson) {
        movies.add(MovieModel.fromJson(movie));
      }

      return movies;
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails({required int movieId}) async {
    try {
      final Response response = await _dio.get(ApiRoutes.movieDetails(movieId));

      final Map<String, dynamic> data = response.data;

      return MovieDetailsModel.fromJson(data);
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw ServerException();
    }
  }
}
