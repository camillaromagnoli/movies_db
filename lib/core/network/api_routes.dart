class ApiRoutes {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageUrl = 'https://image.tmdb.org/t/p/w342';
  static const String popularMovies = '/movie/popular';
  static String movieDetails(int movieId) => '/movie/$movieId';
}
