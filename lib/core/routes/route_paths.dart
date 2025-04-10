abstract class RoutePaths {
  static const String movies = '/';
  static const String movieDetailsPath = '/movie/:$movieId';

  static const String movieId = 'id';

  static String movieDetailsWithId(int id) => '/movie/$id';
}
