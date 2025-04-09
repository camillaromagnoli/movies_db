import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db_app/core/routes/app_routes_path.dart';
import 'package:movie_db_app/features/movies/presentation/cubit/movies/movies_cubit.dart';
import 'package:movie_db_app/features/movies/presentation/widgets/movie_grid_item.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesPage> {
  late ScrollController _scrollController;
  late MoviesCubit cubit;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit = context.read<MoviesCubit>();

      cubit.getPopularMovies(isInitial: true);

      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent &&
            !cubit.isLoadingMore) {
          cubit.getPopularMovies();
        }
      });
    });
    super.initState();
  }

  Widget _buildLoadingFooter() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies', style: TextStyle(fontSize: 24)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<MoviesCubit, MoviesState>(
          builder: (context, state) {
            final cubit = context.read<MoviesCubit>();
            final movies = cubit.movies;

            if (state is MoviesLoading && movies.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is MoviesError) {
              return Center(child: Text('Erro: ${state.message}'));
            }

            return GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: movies.length + (cubit.isLoadingMore ? 1 : 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 16,
                childAspectRatio: 0.55,
              ),
              itemBuilder: (context, index) {
                if (index == movies.length && cubit.isLoadingMore) {
                  return _buildLoadingFooter();
                }

                final movie = movies[index];
                return MovieGridItem(
                  movie: movie,
                  onTap:
                      () => context.push(AppRoutePaths.movieDetails(movie.id)),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    cubit.close();
    super.dispose();
  }
}
