import 'package:bloc/bloc.dart';
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
      super(MoviesInitial());

  Future<void> getPopularMovies({bool isInitial = false}) async {
    if (_isLoadingMore || (!isInitial && state is MoviesLoading)) return;

    if (isInitial) {
      emit(MoviesLoading());
      _movies.clear();
      _page = 1;
    } else {
      _isLoadingMore = true;
      emit(MoviesLoadMore());
    }

    try {
      final response = await _services.getPopularMovies(page: _page);

      _movies.addAll(response);
      _page++;

      emit(MoviesSuccess(List.from(_movies)));
    } catch (e) {
      emit(MoviesError(e.toString()));
    } finally {
      _isLoadingMore = false;
    }
  }
}
