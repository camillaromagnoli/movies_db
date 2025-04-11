class ApiRoutes {
  // Base
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageUrl = 'https://image.tmdb.org/t/p/w342';

  // Movies
  static const String baseMovie = '/movie';
  static const String popularMovies = '$baseMovie/popular';
  static String movieDetails(int movieId) => '$baseMovie/$movieId';
}
