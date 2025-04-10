import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db_app/core/di/injection.dart';
import 'package:movie_db_app/core/routes/route_paths.dart';
import 'package:movie_db_app/features/movies/presentation/cubit/movies/movies_cubit.dart';
import 'package:movie_db_app/features/movies/presentation/pages/movie_details_page.dart';
import 'package:movie_db_app/features/movies/presentation/pages/movies_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePaths.movies,
      builder: (context, state) {
        return BlocProvider<MoviesCubit>(
          create: (context) => getIt<MoviesCubit>(),
          child: const MoviesPage(),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.movieDetailsPath,
      pageBuilder: (context, state) {
        final int movieId = int.parse(
          state.pathParameters[RoutePaths.movieId]!,
        );
        return MaterialPage(child: MovieDetailsPage(movieId: movieId));
      },
    ),
  ],
);
