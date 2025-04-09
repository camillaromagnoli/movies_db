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
      super(MovieDetailsInitial());

  Future<void> getMovieDetails({required int movieId}) async {
    emit(MovieDetailsLoading());
    try {
      final details = await _service.getMovieDetails(movieId: movieId);
      emit(MovieDetailsLoaded(details));
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }
}
