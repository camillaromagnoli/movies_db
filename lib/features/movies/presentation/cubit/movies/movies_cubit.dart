import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_db_app/features/movies/data/services/movies_service.dart';
import 'package:movie_db_app/features/movies/data/models/movie_model.dart';

part 'movies_state.dart';

@Injectable()
class MoviesCubit extends Cubit<MoviesState> {
  final MoviesService _services;
  int _page = 1;
  bool _isLoadingMore = false;
  final List<MovieModel> _movies = [];

  List<MovieModel> get movies => _movies;
  bool get isLoadingMore => _isLoadingMore;

  MoviesCubit({required MoviesService services})
    : _services = services,
      super(MoviesState.initial());

  Future<void> getPopularMovies({bool isInitial = false}) async {
    if (_isLoadingMore ||
        (!isInitial && state.status == MoviesStatus.loading)) {
      return;
    }

    if (isInitial) {
      emit(state.copyWith(status: MoviesStatus.loading));
      _movies.clear();
      _page = 1;
    } else {
      _isLoadingMore = true;
      emit(state.copyWith(status: MoviesStatus.success));
    }

    try {
      final response = await _services.getPopularMovies(page: _page);

      _movies.addAll(response);
      _page++;

      emit(
        state.copyWith(
          status: MoviesStatus.success,
          movies: List.from(_movies),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: MoviesStatus.failure));
    } finally {
      _isLoadingMore = false;
    }
  }
}
