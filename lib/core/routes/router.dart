import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db_app/core/di/injection.dart';
import 'package:movie_db_app/core/routes/app_routes_path.dart';
import 'package:movie_db_app/features/movies/presentation/cubit/movies/movies_cubit.dart';
import 'package:movie_db_app/features/movies/presentation/pages/movie_details_page.dart';
import 'package:movie_db_app/features/movies/presentation/pages/movies_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutePaths.movies,
      builder: (context, state) {
        return BlocProvider<MoviesCubit>(
          create: (context) => getIt<MoviesCubit>(),
          child: const MoviesPage(),
        );
      },
    ),
    GoRoute(
      path: '/movie/:id',
      pageBuilder: (context, state) {
        final movieId = int.parse(state.pathParameters['id']!);

        return MaterialPage(child: MovieDetailsPage(movieId: movieId));
      },
    ),
  ],
);
