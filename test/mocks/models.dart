import 'package:movie_db_app/features/movies/data/models/movie_details_model.dart';
import 'package:movie_db_app/features/movies/data/models/movie_model.dart';

Map<String, dynamic> movieJsonMock = {
  'title': 'Test Movie',
  'release_date': '2025-01-01',
  'overview': 'Description',
  'poster_path': '4VtkIaj76TpQNfhDHXQDdT9uBN5.jpg',
  'id': 1,
};

MovieModel movieModelMock = MovieModel.fromJson(movieJsonMock);

Map<String, dynamic> movieDetailsJsonMock = {
  'title': 'Test Movie',
  'overview': 'A great movie',
  'release_date': '2025-01-01',
  'poster_path': '/poster.jpg',
  'vote_average': 8.5,
  'runtime': 120,
};

MovieDetailsModel movieDetailsMock = MovieDetailsModel.fromJson(
  movieDetailsJsonMock,
);
