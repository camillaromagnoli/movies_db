import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_db_app/features/movies/data/services/movies_service.dart';
import 'package:movie_db_app/features/movies/data/models/movie_model.dart';

part 'movies_state.dart';

@Injectable()
class MoviesCubit extends Cubit<MoviesState> {
  final MoviesService _services;

  MoviesCubit({required MoviesService services})
    : _services = services,
      super(MoviesState.initial());

  Future<void> getPopularMovies({bool isInitial = false}) async {
    if (state.isLoadingMore ||
        (!isInitial && state.status == MoviesStatus.loading)) {
      return;
    }

    if (isInitial) {
      emit(state.copyWith(status: MoviesStatus.loading, movies: [], page: 1));
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }

    try {
      final response = await _services.getPopularMovies(page: state.page);

      final updatedMovies = List<MovieModel>.from(state.movies)
        ..addAll(response);

      emit(
        state.copyWith(
          status: MoviesStatus.success,
          movies: updatedMovies,
          page: state.page + 1,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: MoviesStatus.failure));
    } finally {
      emit(state.copyWith(isLoadingMore: false));
    }
  }
}
