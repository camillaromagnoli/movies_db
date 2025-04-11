part of 'movies_cubit.dart';

enum MoviesStatus { initial, loading, success, failure }

class MoviesState extends Equatable {
  final MoviesStatus status;
  final List<MovieModel> movies;
  final int page;
  final bool isLoadingMore;

  const MoviesState({
    required this.status,
    required this.movies,
    required this.page,
    required this.isLoadingMore,
  });

  factory MoviesState.initial() => const MoviesState(
    status: MoviesStatus.initial,
    movies: [],
    page: 1,
    isLoadingMore: false,
  );

  MoviesState copyWith({
    MoviesStatus? status,
    List<MovieModel>? movies,
    int? page,
    bool? isLoadingMore,
    String? errorMessage,
  }) {
    return MoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      page: page ?? this.page,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [status, movies, page, isLoadingMore];
}
