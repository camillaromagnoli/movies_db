part of 'movies_cubit.dart';

enum MoviesStatus { initial, loading, failure, success }

final class MoviesState extends Equatable {
  final MoviesStatus status;
  final List<MovieModel> movies;

  const MoviesState({required this.status, required this.movies});

  MoviesState._initial() : status = MoviesStatus.initial, movies = [];

  factory MoviesState.initial() => MoviesState._initial();

  MoviesState copyWith({MoviesStatus? status, List<MovieModel>? movies}) =>
      MoviesState(status: status ?? this.status, movies: movies ?? this.movies);

  @override
  List<Object?> get props => [status, movies];
}
