part of 'movie_details_cubit.dart';

enum MovieDetailsStatus { initial, loading, failure, success }

final class MovieDetailsState extends Equatable {
  final MovieDetailsStatus status;
  final MovieDetailsModel? movie;

  const MovieDetailsState({required this.status, required this.movie});

  const MovieDetailsState._initial()
    : status = MovieDetailsStatus.initial,
      movie = null;

  factory MovieDetailsState.initial() => MovieDetailsState._initial();

  MovieDetailsState copyWith({
    MovieDetailsStatus? status,
    MovieDetailsModel? movie,
  }) => MovieDetailsState(
    status: status ?? this.status,
    movie: movie ?? this.movie,
  );

  @override
  List<Object?> get props => [status, movie];
}
