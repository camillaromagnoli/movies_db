import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db_app/core/design/app_bar.dart';
import 'package:movie_db_app/core/routes/route_paths.dart';
import 'package:movie_db_app/core/utils/app_texts.dart';
import 'package:movie_db_app/features/movies/presentation/cubit/movies/movies_cubit.dart';
import 'package:movie_db_app/features/movies/presentation/widgets/movie_card_widget.dart';
import 'package:movie_db_app/features/movies/presentation/widgets/movie_error_widget.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<MoviesCubit>();
      cubit.getPopularMovies(isInitial: true);

      _scrollController.addListener(() {
        final cubit = context.read<MoviesCubit>();
        if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent &&
            !cubit.state.isLoadingMore) {
          cubit.getPopularMovies();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MoviesAppBar(title: AppTexts.popularMoviesAppBarTitle),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<MoviesCubit, MoviesState>(
          builder: (context, state) {
            final cubit = context.read<MoviesCubit>();
            final movies = state.movies;
            if (state.status == MoviesStatus.loading && movies.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == MoviesStatus.failure && movies.isEmpty) {
              return Center(
                child: MoviesErrorWidget(
                  errorMessage: AppTexts.serverErrorMessage,
                  onRefresh: () => cubit.getPopularMovies(isInitial: true),
                ),
              );
            }

            return GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount:
                  movies.length +
                  (state.isLoadingMore || state.status == MoviesStatus.failure
                      ? 1
                      : 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 16,
                childAspectRatio: 0.55,
              ),
              itemBuilder: (context, index) {
                if (index == movies.length) {
                  if (state.status == MoviesStatus.failure) {
                    return MoviesErrorWidget(
                      errorMessage: AppTexts.serverErrorMessage,
                      onRefresh: () => cubit.getPopularMovies(),
                    );
                  }

                  if (state.isLoadingMore) {
                    return const Center(child: CircularProgressIndicator());
                  }
                }

                final movie = movies[index];
                return MovieCardWidget(
                  movie: movie,
                  onTap:
                      () =>
                          context.push(RoutePaths.movieDetailsWithId(movie.id)),
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
    super.dispose();
  }
}
