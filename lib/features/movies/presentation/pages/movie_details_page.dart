import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/core/design/app_bar.dart';
import 'package:movie_db_app/core/di/injection.dart';
import 'package:movie_db_app/core/utils/app_texts.dart';
import 'package:movie_db_app/core/utils/utils.dart';
import 'package:movie_db_app/features/movies/data/models/movie_details_model.dart';
import 'package:movie_db_app/features/movies/presentation/cubit/movie_details/movie_details_cubit.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create:
          (_) => getIt<MovieDetailsCubit>()..getMovieDetails(movieId: movieId),
      child: Scaffold(
        appBar: MoviesAppBar(),
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state.status == MovieDetailsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == MovieDetailsStatus.failure) {
              return Center(child: Text(AppTexts.serviceErrorMessage));
            } else if (state.status == MovieDetailsStatus.success) {
              final MovieDetailsModel movie = state.movie!;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          movie.backdropPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(movie.title, style: textTheme.headlineMedium),
                    Row(
                      spacing: 4.0,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(
                          '${movie.averageRating}',
                          style: textTheme.labelLarge,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppTexts.overviewTitle,
                          style: textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(movie.overview),
                      ],
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppTexts.releaseDateTitle,
                          style: textTheme.titleSmall,
                        ),
                        Text(formatDate(movie.releaseDate)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppTexts.runtimeTitle,
                          style: textTheme.titleSmall,
                        ),
                        Text(
                          '${movie.runtime} ${AppTexts.minutes}',
                          style: textTheme.bodyMedium,
                        ),
                        Text('${movie.runtime} ${AppTexts.minutes}'),
                      ],
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
