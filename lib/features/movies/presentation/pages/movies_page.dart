import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db_app/core/design/app_bar.dart';
import 'package:movie_db_app/core/routes/route_paths.dart';
import 'package:movie_db_app/core/utils/app_texts.dart';
import 'package:movie_db_app/features/movies/presentation/cubit/movies/movies_cubit.dart';
import 'package:movie_db_app/features/movies/presentation/widgets/movie_card.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MoviesAppBar(title: AppTexts.popularMoviesAppBarTitle),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<MoviesCubit, MoviesState>(
          builder: (context, state) {
            final cubit = context.read<MoviesCubit>();
            final movies = cubit.movies;

            if (state.status == MoviesStatus.loading && movies.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            if (state.status == MoviesStatus.failure) {
              return Center(child: Text(AppTexts.serviceErrorMessage));
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
                  return Center(child: CircularProgressIndicator());
                }

                final movie = movies[index];
                return MovieCard(
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
    cubit.close();
    super.dispose();
  }
}
