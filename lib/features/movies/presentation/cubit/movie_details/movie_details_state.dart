// movie_details_state.dart

part of 'movie_details_cubit.dart';

abstract class MovieDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetailsModel details;

  MovieDetailsLoaded(this.details);

  @override
  List<Object?> get props => [details];
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
