import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_db_app/features/movies/data/services/movies_service.dart';
import 'package:movie_db_app/features/movies/data/models/movie_details_model.dart';

part 'movie_details_state.dart';

@Injectable()
class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MoviesService _service;

  MovieDetailsCubit({required MoviesService service})
    : _service = service,
      super(MovieDetailsState.initial());

  Future<void> getMovieDetails({required int movieId}) async {
    emit(state.copyWith(status: MovieDetailsStatus.loading));
    try {
      final movieDetails = await _service.getMovieDetails(movieId: movieId);
      emit(
        state.copyWith(status: MovieDetailsStatus.success, movie: movieDetails),
      );
    } catch (e) {
      emit(state.copyWith(status: MovieDetailsStatus.failure));
    }
  }
}
