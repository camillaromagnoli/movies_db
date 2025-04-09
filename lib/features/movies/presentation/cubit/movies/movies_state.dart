part of 'movies_cubit.dart';

sealed class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoadMore extends MoviesState {}

class MoviesSuccess extends MoviesState {
  final List<MovieModel> movies;
  MoviesSuccess(this.movies);
}

class MoviesError extends MoviesState {
  final String message;
  MoviesError(this.message);
}
