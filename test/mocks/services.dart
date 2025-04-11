import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_db_app/features/movies/data/services/movies_service.dart';

class MoviesServiceMock extends Mock implements MoviesService {}

class DioMock extends Mock implements Dio {}
